output "subnet" {
  value = google_compute_subnetwork.subnet.name
}
output "vpc" {
  value = google_compute_network.vpc.name
}
