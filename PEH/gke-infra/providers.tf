provider "google" {
  project = "cr-lab-cogbunuzor-2806235940"
}

terraform {
  required_version = "1.3.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.62.0"
    }
  }

  backend "gcs" {
    bucket = "tf-state-28062023"
    prefix = "terraform/state/tf-gh-build-project/platform-engineering-hub/gke-infra"
  }
}
