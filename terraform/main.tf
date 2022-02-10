terraform {
  backend "gcs" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<4"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "<2.3"
    }
  }
}

provider "google" {
  project = var.PROJECT_ID
  region  = var.RUN_REGION
}

data "google_project" "default" {}

locals {
  SERVICE_NAME = "pt-streams"
  ROLES = [
    "roles/logging.logWriter",
    "roles/pubsub.publisher",
  ]
  ARCHIVE_NAME = "pt-streams"
}
