variable "project_id" {
  type        = string
  description = "Gcp Project id"
}

variable "region" {
   type       = string
   default    = "us-central1"
}

variable "environment" {
  type        = string
  description = "Environment (dev/test/prod)"
  default     = "dev"
}

variable "vm_machine_type" {
  type = map(string)
  default = {
     dev  = "e2-medium"
     test = "e2-standard-2"
     prod = "n2-standard"
  }
}
