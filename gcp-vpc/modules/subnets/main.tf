resource "google_compute_subnetwork" "subnetwork" {
  provider      = google-beta
  project       = var.project_id
  for_each      = var.subnet_attributes
  name          = each.key
  ip_cidr_range = each.value["subnet_cidr_range"]
  region        = each.value["subnet_region"]
  network       = var.subnet_vpc_name
  purpose       = "${try(each.value["subnet_purpose"], null) == "" ? null : try("${each.value["subnet_purpose"]}","${var.default_subnet_purpose}")}"
  role          = "${try("${each.value["subnet_purpose"]}", null) == "INTERNAL_HTTPS_LOAD_BALANCER" || try("${each.value["subnet_purpose"]}", null) == "REGIONAL_MANAGED_PROXY" ? try("${each.value["subnet_role"]}", null) : null}"
  
  dynamic "secondary_ip_range" {
    for_each = each.value["secondary_subnet_range"]
    content {
      range_name       = secondary_ip_range.value["secondary_subnet_name"]
      ip_cidr_range    = secondary_ip_range.value["secondary_subnet_ip_cidr"]
    }
  }
}