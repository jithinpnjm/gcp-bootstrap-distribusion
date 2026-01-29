variable "project_id" {
  description = "The project ID to setup the environment"
  type        = string
  default     = ""
}

variable "firewall_attributes" {
  description = "The attributes required to create a firewall rule."
  default     = {}
}

variable "firewall_vpc_name" {
  description = <<-EOT
  The name of the VPC to create firewall rule in. This value is passed 
  as a module self link from main.tf
  EOT
  type        = string
  default     = ""
}