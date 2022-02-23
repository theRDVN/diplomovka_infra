resource "google_compute_address" "ops-static-ip" {
  name     = "${var.master_name}"
  region = "${var.region}"
  project = "${var.project}"
}

resource "google_compute_address" "appserver-static-ip" {
  for_each = toset(var.minion_names)
  name     = "${each.value}"
  region = "${var.region}"
  project = "${var.project}"
}
module "master" {
  source = "./modules/master"

  depends_on = [
    google_compute_address.ops-static-ip
  ]

  name = "${var.master_name}"
  zone = "${var.zone}"
  project = "${var.project}"
  machine_type_master = "${var.machine_type_master}"
  vm_image_master = "${var.vm_image_master}"
  vm_disk_size_master = "${var.vm_disk_size_master}"
  internal_ip_master = "${var.internal_ip_master}"
  network_name = "${var.network_name}"
  saltmaster = "${var.saltmaster}"
  saltEnv = "${var.saltEnvCommon}"
  common_services = "${var.common_services}"
  salt_infra = "${var.salt_infra}"
  site_ms = "${var.site_ms}"
  connection_type = "${var.connection_type}"
  ssh_user = "${var.ssh_user}"
  ops_static_ip = "${google_compute_address.ops-static-ip.address}"
  dns_zone = "${var.dns_zone}"
  dns_zone_name = "${var.dns_zone_name}"
  dns_zone_visibility = "${var.dns_zone_visibility}"
  dns_zone_description = "${var.dns_zone_description}"
  record_set_A_type = "${var.record_set_A_type}"
  record_set_ttl = "${var.record_set_ttl}"
}
module "minion" {
  source = "./modules/minion"
  
  for_each = toset(var.minion_names)

  depends_on = [
    module.master,
    google_compute_address.appserver-static-ip
  ]
  
  name = "${each.value}"
  zone = "${var.zone}"
  project = "${var.project}"
  machine_type_minion = "${var.machine_type_minion}"
  vm_image_minion = "${var.vm_image_minion}"
  vm_disk_size_minion = "${var.vm_disk_size_minion}"
  vm_major_release = "${var.vm_major_release_minion}"
  internal_ip_minion = "${var.internal_ip_minion}"
  network_name = "${var.network_name}"
  instance_count = "${var.instance_count}"
  saltmaster = "${module.master.master_hostname}"
  saltEnv = "${var.saltEnv}"
  server_type_ms = "${var.server_type_ms}"
  component_ms = "${var.component_ms}"
  cluster_ms = "${var.cluster_ms}"
  app_user_ms = "${var.app_user_ms}"
  site_ms = "${var.site_ms}"
  connection_type = "${var.connection_type}"
  ssh_user = "${var.ssh_user}"
  app_static_ip = "${google_compute_address.appserver-static-ip[each.key].address}"
  master_external_ip = "${module.master.master_external_ip}"
  dns_zone = "${var.dns_zone}"
  dns_zone_name = "${var.dns_zone_name}"
  dns_zone_visibility = "${var.dns_zone_visibility}"
  dns_zone_description = "${var.dns_zone_description}"
  record_set_A_type = "${var.record_set_A_type}"
  record_set_ttl = "${var.record_set_ttl}"
}