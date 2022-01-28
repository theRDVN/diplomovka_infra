resource "google_compute_instance" "diplomovka_master"{
  name = "${var.name}-ops"
  description = "Vytvori UBUNTU Saltmaster server"
  zone = "${var.zone}"
  project = "${var.project}"
    
  machine_type = "${var.machine_type_master}"

  tags = ["saltmaster", "saltminion", "stackstorm", "ubuntu"]

  metadata = {
      sshKeys = "${var.ssh_user}:${file("C:/Users/pieterr/.ssh/id_rsa.pub")}"
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
    private_key = file("C:/Users/pieterr/.ssh/id_rsa")
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

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/master_setup.sh",
      "sudo /tmp/master_setup.sh",
      "salt-key -A -y"
    ]
  }
}