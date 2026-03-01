backend "gcs" {
  bucket  = "my-terraform-state-dev"
  prefix  = "terraform/state"
  project = var.project_id
}
