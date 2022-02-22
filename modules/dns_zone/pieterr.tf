resource "google_dns_managed_zone" "pieterr_net" {
  name        = "${var.name}"
  dns_name    = "${var.dns_name}"
  project = "${var.project}"
  visibility = "${var.visibility}"
  description = "${var.description}"
  dnssec_config {
    state = "off"
  }
}