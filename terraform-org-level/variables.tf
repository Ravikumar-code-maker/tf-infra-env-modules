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

variable "gcs_bucket_names" {
  type    = list(string)
  default = ["bucket-dev","bucket-test","bucket-prod"]
}

variable "bigquery_datasets" {
  type = map(object({
    location : string
    tables   : list(string)
  }))
  default = {
    dev  = { location = "US", tables = ["dev_table1", "dev_table2"] }
    test = { location = "US", tables = ["test_table1"] } 
    prod = { location = "US", tables = ["prod_table1, "prod_table2"] }
  }
}

variable "firewall_rules" {
  type = list(object({
    name   : string
    network : string
    allow   : list(object({ protocol : string, ports : list(string) }))
    source_ranges : list(string) 
  }))
  default = [
    {
      name    = "allow-ssh"
      network = "vpc-network"
      allow   = [{ protocol = "tcp", ports = ["22"] }]
      source_ranges = ["0.0.0.0/0"]
    }
  ]
}

variable "api_gateway_names" {
  type    = set(string)
  default = ["api-gateway-dev","api-gateway-test","api-gateway-prod"]
}


