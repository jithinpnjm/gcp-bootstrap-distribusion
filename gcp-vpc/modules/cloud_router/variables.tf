variable "cloud_router_attributes" {
  description = "The attributes required to create cloud router"
  type        = map
  default     = {}
}

variable "cloud_router_vpc_name" {
  description = "Map passing the VPC self link to cloud router."
  type        = string
  default     = ""
}
variable "project_id" {
  description = "The project ID to setup the environment"
  type        = string
  default     = ""
}