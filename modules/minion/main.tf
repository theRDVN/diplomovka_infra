resource "template_file" "install_salt_minion" {
  template = "${file("./scripts/install-salt-centos.sh.tpl")}"
  count    = "${var.instance_count}"

  vars = {
    minionId   = "${var.name}-${format("%02d", count.index+1)}"
    hostname   = "${var.name}-${format("%02d", count.index+1)}"
    masterNode = "${var.saltMaster}"
    minionEnv  = "${var.saltEnv}"
  }
}

resource "google_compute_instance" "diplomovka_minion"{
    name = "diplomovka-app"
    description = "Vytvori CentOS Salt-minion server"
    zone = "europe-west1-b"
    # hostname = "diplomovka-app"
    project = "diplomovka-334620"

    machine_type = "e2-medium"

    tags = ["saltminion", "appserver", "centos"]

    metadata = {
        startup-script = "${template_file.install_salt_minion[count.index].rendered}"
    }

    boot_disk {
      initialize_params {
          image = "centos-cloud/centos-8"
          size = "20"
      }
    }

    network_interface {
      network = "default"
      access_config {
        nat_ip = "${google_compute_address.appserver-static-ip.address}"
      }
      network_ip = "10.132.0.4"
    }
}