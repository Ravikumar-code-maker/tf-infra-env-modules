resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_name)
  name     = each.key
  location = var.region
}


