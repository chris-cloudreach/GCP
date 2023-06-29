# https://www.terraform.io/language/settings/backends/gcs
terraform {

  backend "gcs" {
    bucket = "tf-state-28062023"
    prefix = "terraform/state"
  }


}
