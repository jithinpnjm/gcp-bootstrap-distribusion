variable "gcp_nat_attributes" {
  type =map
  description ="nat properties"
  default ={}
}
variable "gcp_router" {
  description = "Map passing the router self link to nat."
  type        = string
  default     = ""
}
variable "project_id" {
  description = "The project ID to setup the environment"
  type        = string
  default     = ""
}
