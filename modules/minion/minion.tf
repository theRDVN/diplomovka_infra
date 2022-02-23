resource "google_compute_instance" "diplomovka_minion"{
  name = "${var.name}"
  description = "Vytvori CentOS Salt-minion server"
  zone = "${var.zone}"
  project = "${var.project}"

  machine_type = "${var.machine_type_minion}"

  tags = ["saltminion", "appserver", "centos", "https-server", "http-server"]

  metadata = {
      sshKeys = "${var.ssh_user}:${file("./files/.ssh/id_rsa.pub")}"
  }

  boot_disk {
    initialize_params {
        image = "${var.vm_image_minion}-${var.vm_major_release}"
        size = "${var.vm_disk_size_minion}"
    }
  }

  network_interface {
    network = "${var.network_name}"
    access_config {
    }
  }
}

resource "null_resource" "install_salt_centos" {
  depends_on = [
    google_compute_instance.diplomovka_minion
  ]
  connection {
  host     = "${google_compute_instance.diplomovka_minion.network_interface.0.access_config.0.nat_ip}"
  type     = "${var.connection_type}"
  user     = "${var.ssh_user}"
  private_key = file("./files/.ssh/id_rsa")
  }

  provisioner "file" {
  content = templatefile("./scripts/install-salt-centos.sh.tpl", {
    hostname   = "${google_compute_instance.diplomovka_minion.name}"
    major_release = "${var.vm_major_release}"
    }
  )
  destination = "/tmp/minion_setup.sh"
  }

  provisioner "file" {
    content = templatefile("./templates/salt-minion-conf.tpl", {
      hostname   = "${google_compute_instance.diplomovka_minion.name}"
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
resource "null_resource" "accept_minion_keys" {
  depends_on = [
    null_resource.install_salt_centos
  ]
  connection {
  host     = "${var.master_external_ip}"
  type     = "${var.connection_type}"
  user     = "${var.ssh_user}"
  private_key = file("./files/.ssh/id_rsa")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo salt-key -A -y",
      "sleep 10;"
    ]
  }
}
resource "google_compute_firewall" "app_firewall_rules" {
  project     = "${var.project}"
  name        = "default-allow-app-external-http-trafic"
  network     = "${var.network_name}"
  description = "Povolenie http portu 80 a 8080 pre aplikacie na aplikacnych serveroch"
  allow {
    protocol  = "tcp"
    ports     = ["80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["appserver", "http-server", "https-server"]
}
resource "google_dns_record_set" "app_pieterr_dns" {
  
  depends_on = [
    null_resource.install_salt_centos
  ]

  name         = "${var.name}.${var.dns_zone}"
  managed_zone = "${var.dns_zone_name}"
  type         = "${var.record_set_A_type}"
  ttl          = "${var.record_set_ttl}"
  rrdatas      = ["${google_compute_instance.diplomovka_minion.network_interface.0.access_config.0.nat_ip}"]
}