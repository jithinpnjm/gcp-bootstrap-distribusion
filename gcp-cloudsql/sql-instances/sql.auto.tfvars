project_id               = "jithin-gcp-1234"
region                   = "us-central1"
network                  = "projects/jithin-gcp-1234/global/networks/us-central1-ds-vpc-01"

# Database Config
db_name                  = "vikunja-production-db"
tier                     = "db-custom-2-7680"
disk_size                = 20

# Private Service Access (PSA)
vpc_peering_address      = "10.8.0.0"
vpc_peering_range_prefix = "16"