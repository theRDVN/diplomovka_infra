output "minion_external_ip" {
  value = "${google_compute_instance.diplomovka_minion.network_interface.0.access_config.0.nat_ip}"
}

output "minion_hostname" {
  value = "${google_compute_instance.diplomovka_minion.name}"
}