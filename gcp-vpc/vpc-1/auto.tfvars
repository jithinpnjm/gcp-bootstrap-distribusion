project_id = "jithin-gcp-1234"
vpc_name                            = "us-central1-ds-vpc-01"
vpc_auto_create_subnetworks         = false
vpc_delete_default_routes_on_create = false
vpc_routing_mode                    = "REGIONAL"
region                              = "us-central1"

subnet_attributes = {
  "us-central1-ds-vpc-1-sb-01" = {
    "subnet_region"                   = "us-central1",
    "subnet_cidr_range"               = "10.255.255.0/24",
    "secondary_subnet_range"          = [
      {
        secondary_subnet_name = "us-central1-gke-svcs-1"
        secondary_subnet_ip_cidr   = "192.168.36.0/25"
      },
      {
        secondary_subnet_name = "us-central1-gke-pods-1"
        secondary_subnet_ip_cidr   = "192.168.35.0/24"
      },
    ]
  },
   "us-central1-ds-vpc-1-sb-02" = {
    "subnet_region"                   = "us-central1",
    "subnet_cidr_range"               = "10.255.254.0/24",
    "secondary_subnet_range" = []  
  },
"l7-us-central1-ds-vpc-1-proxy-only" = {
    "subnet_region"                   = "us-central1",
    "subnet_cidr_range"               = "192.168.32.0/25",
    "subnet_purpose"                  = "REGIONAL_MANAGED_PROXY",
    "subnet_role"                     = "ACTIVE",
    "secondary_subnet_range"          = []
  }
}
firewall_attributes = {
  "permitall" = {
    "firewall_direction" = "INGRESS",
    "firewall_protocols_ports" = [
      {
        "protocol" = "all",
        "ports"    = []
      }
    ],
    "firewall_priority" = 10000,
    "firewall_source_ranges" = [
      "0.0.0.0/0"
    ]
  },

}
cloud_router_attributes = {
  "gc-cloud-router" = {
    "cloud_router_region"               = "us-central1",
  },
}

gcp_nat_attributes = {
gcp-nat = {  
gcp_router_name                  ="gc-cloud-router"
gcp_nat_region                   = "us-central1",
nat_ip_allocate_option             = "AUTO_ONLY"
subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

},
}




