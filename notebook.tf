## REQUIREMENT 1 : VERTEX AI NOTEBOOKS
resource "google_project_service" "notebooks" {
  provider           = google
  service            = "notebooks.googleapis.com"
  disable_on_destroy = false
}

resource "google_notebooks_instance" "assessment_notebook" {
  project      = var.project_name
  name         = var.notebook_name
  provider     = google
  location     = var.zone
  machine_type = var.machine_type

  vm_image {
    project      = var.image_project
    image_family = var.image_family
  }

  depends_on = [
    google_project_service.notebooks
  ]
}
