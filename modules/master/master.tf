locals {
  server_type = "ops"
}
resource "google_compute_instance" "diplomovka_master"{
  name = "${var.name}-${local.server_type}"
  description = "Vytvori UBUNTU Saltmaster server"
  zone = "${var.zone}"
  project = "${var.project}"
    
  machine_type = "${var.machine_type_master}"

  tags = ["saltmaster", "saltminion", "stackstorm", "ubuntu", "https-server", "http-server"]

  metadata = {
      sshKeys = "${var.ssh_user}:${file("./files/.ssh/id_rsa.pub")}"
   }

  boot_disk {
    initialize_params {
        image = "${var.vm_image_master}"
        size = "${var.vm_disk_size_master}"
    }
  }

  network_interface {
    network = "${var.network_name}"
    access_config { 
    }
    network_ip = "${var.internal_ip_master}"
  }
}

resource "null_resource" "install_salt_ubuntu" {
  depends_on = [
    google_compute_instance.diplomovka_master
  ]

  connection {
    host     = "${google_compute_instance.diplomovka_master.network_interface.0.access_config.0.nat_ip}"
    type     = "${var.connection_type}"
    user     = "${var.ssh_user}"
    private_key = file("./files/.ssh/id_rsa")
  }

  provisioner "file" {
  content = templatefile("./scripts/install-salt-ubuntu.sh.tpl", {
    hostname   = "${var.name}-ops"
    }
  )
  destination = "/tmp/master_setup.sh"
  }

  provisioner "file" {
    content = templatefile("./templates/salt-minion-conf.tpl", {
      hostname   = "${var.name}-ops"
      saltmaster = "${var.saltmaster}"
      env  = "${var.saltEnv}"
    }
  )
  destination = "/tmp/minion.conf"
  }

  provisioner "file" {
    content = templatefile("./templates/salt-master-grains.tpl", {
      common_services = "${var.common_services}",
      env = "${var.saltEnv}"
      salt_infra = "${var.salt_infra}"
      site = "${var.site_ms}"
    }
  )
    destination = "/tmp/grains"
  }

  provisioner "file" {
    source = "./templates/salt-master-conf.tpl"
    destination = "/tmp/master.conf"
  }

  provisioner "file" {
    source = "./scripts/install-st2.sh"
    destination = "/tmp/install_st2.sh"
  }
  provisioner "file" {
    source = "./templates/salt-master-gitfs.conf.tpl"
    destination = "/tmp/gitfs.conf"
  }
provisioner "file" {
    source = "./templates/salt-master-gitfs_set.conf.tpl"
    destination = "/tmp/gitfs_set.conf"
  }
  provisioner "file" {
    source = "./templates/salt-master-roots.conf.tpl"
    destination = "/tmp/roots.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/master_setup.sh",
      "sudo /tmp/master_setup.sh",
      "chmod +x /tmp/install_st2.sh",
      "sudo /tmp/install_st2.sh"
    ]
  }
}

resource "google_compute_firewall" "ops_firewall_rules" {
  project     = "${var.project}"
  name        = "default-allow-external-http-trafic"
  network     = "${var.network_name}"
  description = "Povolenie range-u portov na OPS serveri"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "443", "9101"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["stackstorm", "http-server", "https-server"]
}