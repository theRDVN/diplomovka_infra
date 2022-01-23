resource "google_compute_instance" "diplomovka_master"{
    name = "diplomovka-ops"
    description = "Vytvori UBUNTU Saltmaster server"
    zone = "europe-west1-b"
    # hostname = "diplomovka-ops"
    project = "diplomovka-334620"
    
    machine_type = "e2-standard-2"

    tags = ["saltmaster", "saltminion", "stackstorm", "ubuntu"]

    boot_disk {
      initialize_params {
          image = "ubuntu-os-cloud/ubuntu-1804-lts"
          size = "20"
      }
    }

    network_interface {
      network = "default"
      access_config {
        nat_ip = "${google_compute_address.ops-static-ip.address}"
      }
      network_ip = "10.132.0.3"
    }
}

# resource "google_compute_instance" "diplomovka_minion"{
#     name = "diplomovka-app"
#     description = "Vytvori CentOS Salt-minion server"
#     zone = "europe-west1-b"
#     # hostname = "diplomovka-app"
#     project = "diplomovka-334620"

#     machine_type = "e2-medium"

#     tags = ["saltminion", "appserver", "centos"]

#     boot_disk {
#       initialize_params {
#           image = "centos-cloud/centos-8"
#           size = "20"
#       }
#     }

#     network_interface {
#       network = "default"
#       access_config {
#         nat_ip = "${google_compute_address.appserver-static-ip.address}"
#       }
#       network_ip = "10.132.0.4"
#     }
# }

module "minion" {
  source = "./modules/minion"

  instance_count = "${var.instanceCount}"
  saltMaster = "${var.saltMaster}"
  saltEnv    = "${var.saltEnv}"
}