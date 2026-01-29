// version 0.0.1
// Define local modules
locals {
  // Runtime project variables passed
  project_config = toset(flatten([
    for n, p in var.project_attributes : [
      {
        project                             = n
        project_display_name                = try(p.project_display_name, "") == "" ? n : p.project_display_name
        requestor                           = p.requestor
        billing_account                     = p.billing_account
        folder_id                           = p.folder_id
        company                             = try(p.company, "mycompany")
        team_dl                             = p.team_dl
        usecase                             = p.usecase
        services_enable                     = try(p.services_enable,[])
      }
    ]
  ]))
  // Runtime project config given to project module as input
  project_attr = {
    for pr in local.project_config : "${pr.project}" => pr
  }
}

// Create a new project
resource "google_project" "project" {
  for_each        = local.project_attr
  name            = each.value["project_display_name"]
  project_id      = each.key
  billing_account = each.value["billing_account"]
  folder_id           = each.value["folder_id"]
  labels = {
    owner_id        = each.value["requestor"]
    team_dl         = lower("${each.value["team_dl"]}")
    usecase         = replace(trimspace(lower("${each.value["usecase"]}")), " ", "_")
    branded_bu      = lower("${each.value["company"]}")
  }
  lifecycle {
    ignore_changes = [
      labels
    ]
  }
}
locals {
  // Merge default services with runtime services, runtime services can be empty
  api_service_enable = toset(flatten([
    for n, p in local.project_attr : [
      for service in p.services_enable : {
        project         = n
        services_enable = service
      }
    ]
  ]))
}
// Enable services for a project
resource "google_project_service" "service" {
  for_each = {
    for api_enable in local.api_service_enable : "${api_enable.project}.${api_enable.services_enable}" => api_enable
  }
  service                    = each.value.services_enable
  project                    = google_project.project[each.value.project].project_id
  disable_dependent_services = true
  disable_on_destroy         = true
  depends_on                 = [google_project.project]
}