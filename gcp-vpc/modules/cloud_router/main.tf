resource "google_compute_router" "cloud_router" {
  for_each = var.cloud_router_attributes
  name     = each.key
  network  = var.cloud_router_vpc_name
  region   = each.value["cloud_router_region"]
  project  = var.project_id
}
output "self_link" {
  value = {
    for cloud_router in google_compute_router.cloud_router :
    cloud_router.name => cloud_router.name
  }
}