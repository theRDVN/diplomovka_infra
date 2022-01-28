output "master_external_ip" {
  value = "${google_compute_instance.diplomovka_master.network_interface.0.access_config.0.nat_ip}"
}

output "master_hostname" {
  value = "${google_compute_instance.diplomovka_master.name}"
}
