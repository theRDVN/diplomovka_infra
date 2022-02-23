# VM variables
variable "name" {
  description = "Name to be used on all resources as prefix"
  default = "diplomovka-app-01"
}
variable "zone" {
  description = "Zone where is VM located"
  default = "europe-west1-b"
}
variable "project" {
  description = "Project in GCP"
  default = "diplomovka-334621" # OLD def= diplomovka-334620
}
variable "machine_type_minion" {
  description = "Type of GCP VM"
  default = "e2-medium"
}
variable "vm_image_minion" {
  description = "Image used to create VM"
  default = "centos-cloud/centos-7"
}
variable "vm_major_release" {
  description = "Major release of VM image"
  default = "7"
}
variable "vm_disk_size_minion" {
  description = "Size of disk on VM"
  default = "20"
}
variable "internal_ip_minion" {
  description = "Internal IP for salt-master VM"
}
variable "app_static_ip" {
  description = "Internal IP for salt-master VM"
}
variable "network_name" {
  description = "Network name"
  default = "default"
}
variable "instance_count" {
  description = "Number of instances to launch"
  type = number
  default     = 1
}
# SaltStack variables
variable "saltmaster" {
  description = "DNS for minion config"
  default = ""
}
variable "saltEnv" {
  description = "Environment of saltstack on SaltMaster VM"
  default = "base"
}
variable "server_type_ms" {
  description = "Server type - for what will be server used"
  default = "app"
}
 variable "component_ms"{
   description = "What component will run on server"
   default = [""]
 }  
variable "cluster_ms" {
  description = "Cluster which server belongs to"
  default = "diplomovka"
}
variable "app_user_ms" {
  description = "User running commands"
  default = "rado_pieter"
}   
variable "site_ms" {
  description = "Server site"
  default = "diplomovka"
}
# Connection variables
variable "connection_type" {
  description = "Type of connection to VM"
  default = "ssh"
}
variable "ssh_user" {
  default = "rado_pieter"
  description = ""
}
variable "master_external_ip" {
  description = "Master IP"
}
# DNS zone variables
variable "dns_zone_name" {
  description = "DNS zone name (id)"
}
variable "dns_zone" {
  description = "DNS zone name (URL)"
}   
variable "dns_zone_visibility" {
  description = "Visibility of DNS zone"
}
variable "dns_zone_description" {
  description = "Description of DNS zone"
}
# DNS Record set - publish
variable "record_set_A_type" {
  description = "Record set type"
}
variable "record_set_ttl" {
  description = "Record set TTL"
}