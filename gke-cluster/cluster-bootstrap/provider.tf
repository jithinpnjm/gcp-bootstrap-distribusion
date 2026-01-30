terraform {
  backend "gcs" {
    bucket = "tf-state-ds-dev"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.0.0"
    }
  }
  required_version = ">= 1.6.0"
}

provider "google" {
  project = var.project_id
  region  = var.cluster_location
}

provider "google-beta" {
  project = var.project_id
  region  = var.cluster_location
}