variable "project_id" {
  type = string
}

variable "secret_list" {
  description = "A simple list of Secret IDs to create and generate passwords for."
  type        = list(string)
}

variable "k8s_access_map" {
  description = "A map defining which namespaces/SAs get access to which secrets."
  type = map(object({
    namespace = string
    sa_name   = string
    secrets   = list(string)
  }))
  default = {}
}