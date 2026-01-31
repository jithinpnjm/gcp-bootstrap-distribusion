project_id          = "jithin-gcp-1234"
region              = "us-central1"
network             = "projects/jithin-gcp-1234/global/networks/us-central1-ds-vpc-01"

db_instance_name    = "vikunja-production-db"
tier                = "db-g1-small"
disk_size            = 10

root_password_secret = "db_root_pass"

databases = {
  vikunja = {
    db_name         = "vikunja"
    user_name       = "vikunja_user"
    password_secret = "vikunja-db-password"
  }
  keycloak = {
    db_name         = "keycloak"
    user_name       = "keycloak_user"
    password_secret = "keycloak-db-password"
  }
}

vpc_peering_address      = "10.8.0.0"
vpc_peering_range_prefix = 16




