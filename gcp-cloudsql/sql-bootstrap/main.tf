data "google_secret_manager_secret_version" "root_password" {
  project = var.project_id
  secret  = var.root_password_secret
}

data "google_secret_manager_secret_version" "db_user_passwords" {
  for_each = var.databases
  project  = var.project_id
  secret   = each.value.password_secret
}

module "postgresql_db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "25.1.0"

  name             = var.db_instance_name
  database_version = var.database_version
  project_id       = var.project_id
  region           = var.region
  tier             = var.tier

  availability_type = "REGIONAL"
  disk_size         = var.disk_size
  disk_type         = "PD_SSD"

  user_password = data.google_secret_manager_secret_version.root_password.secret_data
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

resource "google_sql_database" "databases" {
  for_each = var.databases

  name     = each.value.db_name
  project = var.project_id
  instance = module.postgresql_db.instance_name
}

resource "google_sql_user" "users" {
  for_each = var.databases

  name     = each.value.user_name
  project = var.project_id
  instance = module.postgresql_db.instance_name
  password = data.google_secret_manager_secret_version.db_user_passwords[each.key].secret_data
}
