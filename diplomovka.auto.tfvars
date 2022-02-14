master_name = "diplomovka"
minion_names = ["diplomovka-app-01"]
zone = "europe-west1-b"
project = "diplomovka-334621"
network_name = "default"
# ------------------------------------
site_ms = "diplomovka"
# ------------------------------------
connection_type = "ssh"
ssh_user = "rado_pieter"
# ----------------------------------------------
# Globalne nastavenia master VM
# ----------------------------------------------
machine_type_master = "e2-standard-2"
vm_image_master = "ubuntu-os-cloud/ubuntu-1804-lts"
vm_disk_size_master = "20"
internal_ip_master = "10.132.0.3" #Required - nema default hodnotu
# SaltStack variables - master node
saltmaster = "localhost"
saltEnvCommon = "common"
common_services = ["stackstorm", "saltmaster", "saltapi"]
salt_infra = ["master"]
# ----------------------------------------------
# Globalne nastavenia minion VMs
# ----------------------------------------------
machine_type_minion = "e2-medium"
vm_image_minion = "centos-cloud/centos"
vm_major_release_minion = "7"
vm_disk_size_minion = "20"
# Za kazdu zadanu internal IP vytvori 1 instanciu  -> TBA
internal_ip_minion = "10.132.0.4" # Required - nema default hodnotu
instance_count = 1
# SaltStack variables - minion node
saltEnv = "base"
server_type_ms = "app"
component_ms = [""]
cluster_ms = "diplomovka"
app_user_ms = "rado_pieter"