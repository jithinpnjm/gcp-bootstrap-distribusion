variable "org_id" {
  description = "Org ID based on org_node"
  type        = map(any)
  default = {
    dev = "684922988114"
  }

}
// Folder config

variable "folder_business_units" {
  description = "Business unit folder list."
  type        = map(any)

}

variable "subfolders" {
  description = "sub folder map."
  type        = map(any)

}
variable "cos" {
  type        = string
  description = "class of service for gcp i.e test,prod,dev"
}

