# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "cr-lab-cogbunuzor-2806235940"
  region  = "us-central1"
}

provider "google-beta" {
  project = "cr-lab-cogbunuzor-2806235940"
  region  = "us-central1"
}

terraform {
  required_version = "1.3.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.71.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.71.0"
    }


  }
  backend "gcs" {
    bucket = "tf-state-28062023"
    prefix = "terraform/state"
  }
}
