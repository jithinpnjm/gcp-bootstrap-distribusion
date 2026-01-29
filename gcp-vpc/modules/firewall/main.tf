resource "google_compute_firewall" "vpc_firewall_rule" {
  for_each  = var.firewall_attributes
  project   = var.project_id
  name      = each.key
  priority  = each.value["firewall_priority"]
  network   = var.firewall_vpc_name
  direction = each.value["firewall_direction"]
  dynamic "allow" {
    for_each = try(each.value["firewall_protocols_ports"],{})
    content {
      protocol = allow.value["protocol"]
      ports    = allow.value["ports"]
    }
  }
  dynamic "deny" {
    for_each = try(each.value["deny_firewall_protocols_ports"],{})
    content {
      protocol = deny.value["protocol"]
      ports    = deny.value["ports"]
    }
  }
  source_ranges = each.value["firewall_source_ranges"]
  target_tags = try(each.value["target_tags"],null)
}