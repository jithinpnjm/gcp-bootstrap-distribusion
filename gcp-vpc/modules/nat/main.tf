resource "google_compute_router_nat" "gcp-nat" {
  for_each                           = var.gcp_nat_attributes
  name                               = each.key
  router                             = each.value["gcp_router_name"]
  nat_ip_allocate_option             = each.value["nat_ip_allocate_option"]
  region                             = each.value["gcp_nat_region"]
  source_subnetwork_ip_ranges_to_nat = each.value["subnetwork_ip_ranges_to_nat"]
  project                            = var.project_id

}