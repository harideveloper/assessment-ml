terraform {
  required_version = ">=1.0.0"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

# Provider
provider "google" {    
  project = var.project_name
}
provider "google-beta" { 
  project = var.project_name
}
