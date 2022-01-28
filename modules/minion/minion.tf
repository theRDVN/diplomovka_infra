resource "google_compute_instance" "diplomovka_minion"{
  
  name = "${var.name}-app"
  description = "Vytvori CentOS Salt-minion server"
  zone = "${var.zone}"
  project = "${var.project}"
  count = "${var.instance_count}"

  machine_type = "${var.machine_type_minion}"

  tags = ["saltminion", "appserver", "centos"]

  metadata = {
      sshKeys = "${var.ssh_user}:${file("C:/Users/pieterr/.ssh/id_rsa.pub")}"
  }

  boot_disk {
    initialize_params {
        image = "${var.vm_image_minion}"
        size = "${var.vm_disk_size_minion}"
    }
  }

  network_interface {
    network = "${var.network_name}"
    access_config {
    }
    network_ip = "${var.internal_ip_minion}"
  }
}

resource "null_resource" "install_salt_centos" {
  depends_on = [
    google_compute_instance.diplomovka_minion
  ]
  
  count = "${var.instance_count}"
  
  connection {
  host     = "${google_compute_instance.diplomovka_minion[count.index].network_interface.0.access_config.0.nat_ip}"
  type     = "${var.connection_type}"
  user     = "${var.ssh_user}"
  private_key = file("C:/Users/pieterr/.ssh/id_rsa")
  }

  provisioner "file" {
  content = templatefile("./scripts/install-salt-centos.sh.tpl", {
    hostname   = "${var.name}-${format("%02d", count.index+1)}"
    }
  )
  destination = "/tmp/minion_setup.sh"
  }

  provisioner "file" {
    content = templatefile("./templates/salt-minion-conf.tpl", {
      hostname   = "${var.name}-${format("%02d", count.index+1)}"
      saltmaster = "${var.saltmaster}"
      env  = "${var.saltEnv}"
    }
  )
  destination = "/tmp/minion.conf"
  }

  provisioner "file" {
    content = templatefile("./templates/salt-minion-grains.tpl", {
      env          = "${var.saltEnv}"
      server_type  = "${var.server_type_ms}"
      component    = "${var.component_ms}"
      cluster      = "${var.cluster_ms}"
      project      = "${var.project}"
      network_name = "${var.network_name}"
      app_user     = "${var.app_user_ms}"
      site         = "${var.site_ms}"
      }
    )
    destination = "/tmp/grains"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/minion_setup.sh",
      "sudo /tmp/minion_setup.sh"
    ]
  }
}