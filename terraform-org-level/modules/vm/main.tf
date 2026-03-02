resource "google_compute_address" "vm_ip" {
  name = "${var.env}-vm-ip"
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.env}-vm"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
       image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    subnetwork = var.subnetwork
    access_config {
      nat_ip = google_compute_address.vm_ip.address
    }
  }
  metadata = var.metadata
  tags     = var.tags
}
