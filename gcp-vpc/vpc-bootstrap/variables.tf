variable "vpc_name" {
  description = "The name of the VPC network to be created."
  type        = string
  default     = ""
}

variable "subnet_attributes" {
  description = "The attributes required to create subnet resource."
  #type        = map
  default     = {}
}

variable "project_id" {
  description = "The project ID to setup the environment"
  type        = string
  default     = ""
}
variable region {
  description = "region where vpc is created"
  default = {}
}

variable "vpc_routing_mode" {
  description = <<-EOT
  The network-wide routing mode to use. If set to REGIONAL, this network's 
  cloud routers will only advertise routes with subnetworks of this network in 
  the same region as the router. If set to GLOBAL, this network's cloud routers 
  will advertise routes with all subnetworks of this network, across regions.
  EOT
  type        = string
  default     = ""
}

variable "vpc_delete_default_routes_on_create" {
  description = <<-EOT
  If set to true, default routes (0.0.0.0/0) will be deleted immediately after 
  network creation. Defaults to false.
  EOT
  type        = bool
}

variable "vpc_auto_create_subnetworks" {
  description = <<-EOT
  When set to true, the network is created in "auto subnet mode" and it will 
  create a subnet for each region automatically across the 10.128.0.0/9 address 
  range. When set to false, the network is created in "custom subnet mode" so 
  the user can explicitly connect subnetwork resources.
  EOT
  type        = bool
}

variable "gcp_nat_attributes" {
  type =map
  description ="nat properties"
  default ={}
}
variable "cloud_router_attributes" {
  description = "The attributes required to create cloud router"
  type        = map
  default     = {}
}
variable "firewall_attributes" {
  description = "The attributes required to create a firewall rule."
  default     = {}
}

variable "gcp_router_name" {
  description = " passing the router name to nat."
  type        = string
  default     = ""
}



