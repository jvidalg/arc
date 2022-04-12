data "google_project" "this" {
  project_id = local.project_id
}

resource "google_project_service" "container" {
  depends_on = [
    data.google_project.this
  ]
  project = local.project_id
  service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "compute" {
  depends_on = [
    data.google_project.this
  ]
  project = local.project_id
  service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

