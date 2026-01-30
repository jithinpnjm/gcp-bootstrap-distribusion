variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "db_instance_name" {
  type = string
}

variable "database_version" {
  type    = string
  default = "POSTGRES_15"
}

variable "tier" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "root_password_secret" {
  type = string
}

variable "databases" {
  type = map(object({
    db_name         = string
    user_name       = string
    password_secret = string
  }))
  default = {}
}

variable "vpc_peering_address" {
  type = string
}

variable "vpc_peering_range_prefix" {
  type = number
}
