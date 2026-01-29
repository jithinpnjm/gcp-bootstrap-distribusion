variable "project_id" {
  type = string
}

variable "gke_version" {
  type = string
}

variable "name" {
  type = string
}

variable "cluster_location" {
  type = string
}

variable "node_locations" {
  type = list(string)
}

variable "gke_upgrade_channel" {
  type    = string
  default = "STABLE"
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "serviceaccount" {
  type = string
}

variable "master_private_cidr_block" {
  type = string
}

variable "pods_cidr_range_name" {
  type = string
}

variable "services_cidr_range_name" {
  type = string
}

variable "master_authorized_network_cidr" {
  type = list(map(string))
  default = [
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "default"
    }
  ]
}

variable "default_max_pods_per_node" {
  type = string
}

variable "node_pool_attributes" {
  type    = map(any)
  default = {}
}

variable "auto_repair_nodes" {
  type    = bool
  default = true
}

variable "auto_upgrade_nodes" {
  type    = bool
  default = false
}

variable "addon_http_load_balancing" {
  type    = bool
  default = true
}

variable "addon_gce_persistent_disk_csi_driver_config" {
  type    = bool
  default = true
}

variable "addon_dns_local_cache" {
  type    = bool
  default = true
}

variable "addon_config_connector_config" {
  type    = bool
  default = false
}

variable "allowed_image_registries" {
  type    = list(string)
  default = ["*"]
}

variable "enable_l4_ilb_subsetting" {
  type    = bool
  default = false
}