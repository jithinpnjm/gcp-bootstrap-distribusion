resource "random_password" "generated_passwords" {
  for_each = toset(var.secret_list)
  length   = 24
  special  = true
}

resource "google_secret_manager_secret" "secrets" {
  for_each  = toset(var.secret_list)
  secret_id = each.value
  project   = var.project_id
  replication { auto {} }
}

resource "google_secret_manager_secret_version" "versions" {
  for_each    = toset(var.secret_list)
  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = random_password.generated_passwords[each.key].result
}

locals {
  # This flattens the input map so Terraform can loop over every Secret+Namespace+SA combo
  iam_bindings = flatten([
    for app_key, config in var.k8s_access_map : [
      for secret_id in config.secrets : {
        id        = "${app_key}-${secret_id}"
        secret    = secret_id
        namespace = config.namespace
        sa        = config.sa_name
      }
    ]
  ])
}

resource "google_secret_manager_secret_iam_member" "workload_identity_access" {
  for_each  = { for binding in local.iam_bindings : binding.id => binding }
  secret_id = each.value.secret
  role      = "roles/secretmanager.secretAccessor"
  member    = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${each.value.namespace}/sa/${each.value.sa}"

  depends_on = [google_secret_manager_secret.secrets]
}