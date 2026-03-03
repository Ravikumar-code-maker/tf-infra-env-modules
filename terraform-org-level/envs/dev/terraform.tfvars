region            = "us-central1"
gcs_bucket_names  = ["bucket-dev","bucket-test","bucket-prod"]
vm_machine_type   = { dev="e2-medium", test="e2-standard-2", prod="n2-standard" }
firewall_rules    = [
  {
    name          = "allow-ssh"
    network       = "vpc-network"
    allow         = [{ protocol="tcp", ports=["22"] }]
    source_ranges = ["0.0.0.0/0"]
  }
]
bigquery_datasets = {
  dev  = { location="US", tables=["dev_table1","dev_table2"] }
  test = { location="US", tables=["test_table1"] }
  prod = { location="US", tables=["prod_table1","prod_table2"] }
}
api_gateway_names = ["api-gateway-dev","api-gateway-test","api-gateway-prod"]
