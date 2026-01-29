resource "google_compute_network" "vpc_network" {
  name                            = "${var.vpc_name}"
  description                     = "VPC  ${var.vpc_name} created in ${var.project_id}"
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  routing_mode                    = "${var.vpc_routing_mode}"
  project                         = "${var.project_id}"
  delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
}