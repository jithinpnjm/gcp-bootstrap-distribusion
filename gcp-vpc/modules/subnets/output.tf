output "self_link" {
  value = {
    for subnetwork in google_compute_subnetwork.subnetwork :
    subnetwork.name => subnetwork.self_link
  }
}