module "master" {
  source = "./modules/master"

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
}

module "minion" {
  source = "./modules/minion"

  depends_on = [
    module.master
  ]
  
  name = "${var.minion_names}"
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
}

resource "null_resource" "startup_scripts" {
  depends_on = [
    module.master,
    module.minion
  ]

  connection {
    host     = "${module.master.master_external_ip}"
    type     = "${var.connection_type}"
    user     = "${var.ssh_user}"
    private_key = file("./files/.ssh/id_rsa")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo salt-key -A -y",
    ]
  }
}