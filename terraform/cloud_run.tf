data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service" "api" {
  name     = "${var.service_name}-time2block-api"
  location = var.region
  labels = {
    service_name = var.service_name
  }
  template {
    scaling {
      max_instance_count = 5
    }
    containers {
      image = local.image_name
      ports {
        container_port = 8000
      }
    }
    service_account = var.client_email
  }
  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
  depends_on = [
    google_project_service.cloud_run_api,
  ]
}

resource "google_cloud_run_v2_service_iam_policy" "api_noauth" {
  location    = google_cloud_run_v2_service.api.location
  project     = google_cloud_run_v2_service.api.project
  name        = google_cloud_run_v2_service.api.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
