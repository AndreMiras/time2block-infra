terraform {
  backend "gcs" {
    bucket      = "t2b-bucket-tfstate"
    prefix      = "terraform/state"
    credentials = "terraform-service-key.json"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.39, < 5.0"
    }
  }
}

provider "google" {
  project     = var.project
  credentials = file(var.credentials)
  region      = var.region
  zone        = var.zone
}

resource "google_storage_bucket" "default" {
  name          = "${var.service_name}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_project_service" "resource_manager_api" {
  project            = "time2block"
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_run_api" {
  project            = var.project
  service            = "run.googleapis.com"
  disable_on_destroy = false
}
