module "vpc" {
  source       = "../../modules/vpc"
  network_name = "dev-vpc"bucket
  subnet_cidr  = "10.0.1.0/24"
  region       = var.region
  firewall_rules = var.firewall_rules
}

module "vm" {
  source = "../../modules/vm"
  env    = "dev"
  machine_type = var.vm_machine_type["dev"]
  zone         = "${var.region}-a"
  subnetwork   =  module.vpc.subnet[0].name
  metadata     = { env = "dev" }
  tags         = [ "dev" ]
}

module "gcs" {
  source       = "../../modules/gcs"
  bucket_names = var.gcs_bucket_names
  region       = var.region
}

module "bigquery" {
  source    = "../../modules/bigquery"
  datasets  = { dev = var.bigquery_datasets["dev"] }
}

module "apigateway" {
  source        = "../../modules/apigateway"
  gateway_names = var.api_gateway_names
  region        = var.region
}
