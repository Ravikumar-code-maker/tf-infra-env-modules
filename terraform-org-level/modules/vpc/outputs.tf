output "subnet" {
  value = google_compute_subnetwork.subnetwork.name
}
output "vpc" {
  value = google_compute_network.vpc.name
}

