output "vm_name" { value = google_compute_instance.vm_instance.name }
output "vm_ip"   { value = google_compute_address.vm_ip.address }
