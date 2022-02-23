master_name = "diplomovka"
minion_names = ["diplomovka-app-01"]
zone = "europe-west1-b"
project = "diplomovka-334621"
region = "europe-west1"
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
component_ms = ["docker, java"]
cluster_ms = "diplomovka"
app_user_ms = "docker"
# DNS Zone variables
dns_zone_name = "pieterr-net"
dns_zone = "pieterr.net."
dns_zone_visibility = "public"
dns_zone_description = "DNS zone for domain: pieterr.net"
# DNS Record sets variables
record_set_A_type = "A"
record_set_ttl = 31449600