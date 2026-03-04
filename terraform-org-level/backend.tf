terraform {
  backend "gcs" {
    bucket  = "sample-terraform-state-dev1"
    prefix  = "terraform/state"
  }
}




