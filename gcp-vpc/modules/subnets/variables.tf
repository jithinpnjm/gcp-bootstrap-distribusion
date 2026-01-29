variable "subnet_attributes" {
  description = "The attributes required to create subnet resource."
  #type        = map
  default     = {}
}

variable "default_subnet_purpose" {
  description = "The attributes required to create subnet resource."
  type        = string
  default     = "PRIVATE"
}

variable "project_id" {
  description = "The project ID to setup the environment"
  type        = string
  default     = ""
}

variable "subnet_vpc_name" {
  description = <<-EOT
  The name of the VPC to create subnet in. This value is passed 
  as a module self link from main.tf
  EOT
  type        = string
  default     = ""
}