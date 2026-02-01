project_id                = "jithin-gcp-1234"
gke_version               = "1.33.5-gke.2100000"
name                      = "ds-gke-test-01"
cluster_location          = "us-central1"
node_locations            = ["us-central1-a", "us-central1-f",]
network                   = "projects/jithin-gcp-1234/global/networks/us-central1-ds-vpc-01"
subnetwork                = "projects/jithin-gcp-1234/regions/us-central1/subnetworks/us-central1-ds-vpc-1-sb-01"
master_private_cidr_block = "192.168.33.0/28"
pods_cidr_range_name      = "us-central1-gke-pods-1"
services_cidr_range_name   = "us-central1-gke-svcs-1"
default_max_pods_per_node = "16"
serviceaccount           = "svc-gke-nodes-local@jithin-gcp-1234.iam.gserviceaccount.com"
auto_repair_nodes         = true
auto_upgrade_nodes        = false
gke_upgrade_channel       = "UNSPECIFIED"

master_authorized_network_cidr = [
  {
    cidr_block   = "10.255.254.0/24"
    display_name = "subnet: us-central1-ds-vpc-1-sb-02"
  }
]

addon_http_load_balancing           = true
addon_gce_persistent_disk_csi_driver_config = true
addon_dns_local_cache               = true

allowed_image_registries = [
  "docker.io/*",
  "quay.io/*",
  "gcr.io/*",
  "us-docker.pkg.dev/*",
  "ghcr.io/*",
  "docker.io/vikunja/*",
  "docker.io/bitnami/*",
  "docker.io/bitnamilegacy/*",
]


node_pool_attributes = {
  "ds-generic-pool-1" = {
    node_count                       = 1
    disk_size_gb                     = 30
    version                          = "1.33.5-gke.2100000"
    disk_type                        = "pd-standard"
    machine_type                     = "e2-standard-2"
    max_pods                         = 32
    auto_scaling_max_nodes           = 3
    auto_scaling_min_nodes           = 1
    node_max_surge_on_upgrades       = 1
    node_max_unavailable_on_upgrades = 0
    taints_configs                   = []
    nodepool_locations               = ["us-central1-a", "us-central1-f",]
    pod_secondary_range              = ""
    node_image_type                  = "cos_containerd"
  }
}



