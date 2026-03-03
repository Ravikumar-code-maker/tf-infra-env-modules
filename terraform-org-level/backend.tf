terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-dev1"
    prefix  = "terraform/state"
  }
}



