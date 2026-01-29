project_id = "jithin-gcp-1234"

secret_list = [
  "db_root_pass",
  "vikunja-db-password",
  "keycloak-db-password"
]

# 2. Map the secrets to the specific GKE identities
k8s_access_map = {
  "vikunja-app" = {
    namespace = "default"
    sa_name   = "vikunja-sa"
    secrets   = ["vikunja-db-password"]
  },
  "keycloak-app" = {
    namespace = "auth"
    sa_name   = "keycloak-sa"
    secrets   = ["keycloak-db-password"]
  }
}