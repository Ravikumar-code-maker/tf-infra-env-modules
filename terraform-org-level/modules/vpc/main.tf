resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.network_name}"-subnetwork
  region        = var.region
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "firewall" {
  for_each = { for r in var.firewall_rules : r.name => r }
  name          = each.value.name
  network       = google_compute_network.vpc.id
  allow         = each.value.allow
  source_ranges = each.value.source_ranges
}
