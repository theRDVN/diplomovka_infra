# VM variables
variable "name" {
  description = "Name of salt-master VM in GClout UI"
  default = "diplomovka-ops"
}
variable "zone" {
  description = "Zone where is VM located"
  default = "europe-west1-b"
}
variable "project" {
  description = "Project in GCP"
  default = "diplomovka-334620"
}
variable "machine_type_master" {
  description = "Type of GCP VM"
  default = "e2-standard-2"
}
variable "vm_image_master" {
  description = "Image used to create VM"
  default = "ubuntu-os-cloud/ubuntu-1804-lts"
}
variable "vm_disk_size_master" {
  description = "Size of disk on VM"
  default = "20"
}
variable "internal_ip_master" {
  description = "Internal IP for salt-master VM"
}
variable "network_name" {
  description = "Network name"
  default = "default"
}
# SaltStack variables
variable "saltmaster" {
  description = "DNS for minion config"
  default = "localhost"
}
variable "saltEnv" {
  description = "Environment of saltstack on SaltMaster VM"
  default = "common"
}
variable "common_services" {
  description = "Common services install on SaltMaster VM"
  default = ["stackstorm", "saltmaster", "saltapi"]
}
variable "salt_infra" {
  description = "Salt infra"
  default = ["master"]
}
variable "site_ms" {
  description = "Site of saltstack"
  default = "diplomovka"
}
# Connection variables
variable "connection_type" {
  description = "Type of connection to VM"
  default = "ssh"
}
variable "ssh_user" {
  description = "User account for ssh connection to salt-master VM"
  default = "rado_pieter"
}