variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "db_name" {
  type    = string
  default = "vikunja-app-db"
}

variable "tier" {
  type    = string
  default = "db-custom-2-7680"
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "vpc_peering_address" {
  type    = string
  default = "10.8.0.0"
}

variable "vpc_peering_range_prefix" {
  type    = string
  default = "16"
}