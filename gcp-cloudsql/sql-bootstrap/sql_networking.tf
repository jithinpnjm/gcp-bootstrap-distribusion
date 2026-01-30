resource "google_compute_global_address" "vpc_peering_private_ip_block" {
  name          = "vpc-peering-private-ip-block"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address       = var.vpc_peering_address
  prefix_length = var.vpc_peering_range_prefix
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.vpc_peering_private_ip_block.name]
}
