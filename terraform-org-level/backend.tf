terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-dev1"
    prefix  = "terraform/state"
    project = var.project_id
  }
}


