variable "gcs_bucket_name" {
  type    = list(string)
  default = ["bucket-dev","bucket-test","bucket-prod"]

}

variable "region" {
  type    = string
  default = "US"
}



