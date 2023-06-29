# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "cr-lab-cogbunuzor-2806235940"
  region  = "us-central1"
}

terraform {
  required_version = "1.3.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
