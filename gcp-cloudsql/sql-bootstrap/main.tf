# Fetching secrets from Secret Manager
data "google_secret_manager_secret_version" "db_root_pass" {
  project = var.project_id
  secret  = "allex-secret-postgres-postgres-password"
}

data "google_secret_manager_secret_version" "vikunja_pass" {
  project = var.project_id
  secret  = "vikunja-db-password"
}

data "google_secret_manager_secret_version" "keycloak_pass" {
  project = var.project_id
  secret  = "keycloak-db-password"
}

module "postgresql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "25.1.0"

  name             = var.db_name
  database_version = "POSTGRES_15"
  project_id       = var.project_id
  region           = var.region
  tier             = var.tier
  
  availability_type = "REGIONAL"
  disk_size         = var.disk_size
  disk_type         = "PD_SSD"
  
  # Root user password from Secret Manager
  user_password = data.google_secret_manager_secret_version.db_root_pass.secret_data

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled    = false
    private_network = var.network
  }

  backup_configuration = {
    enabled                        = true
    point_in_time_recovery_enabled = true
    retained_backups               = 7
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

# Database for Vikunja
resource "google_sql_database" "vikunja_db" {
  name     = "vikunja"
  instance = module.postgresql-db.instance_name
}

# Database for Keycloak
resource "google_sql_database" "keycloak_db" {
  name     = "keycloak"
  instance = module.postgresql-db.instance_name
}

# User for Vikunja (password fetched from Secret Manager)
resource "google_sql_user" "vikunja_user" {
  name     = "vikunja_user"
  instance = module.postgresql-db.instance_name
  password = data.google_secret_manager_secret_version.vikunja_pass.secret_data
}

# User for Keycloak (password fetched from Secret Manager)
resource "google_sql_user" "keycloak_user" {
  name     = "keycloak_user"
  instance = module.postgresql-db.instance_name
  password = data.google_secret_manager_secret_version.keycloak_pass.secret_data
}