// Enabled services in the project
output "projects_services" {
  value = google_project_service.service
}

// Project details
output "projects" {
  value = google_project.project
}