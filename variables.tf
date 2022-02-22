# Common variables
variable "master_name" {
  description = "Name to be used on all resources as prefix"
}
variable "minion_names" {
  type = list(string)
  description = "Name to be used on all resources as prefix"
}
variable "zone" {
  description = "Zone where is VM located"
}
variable "project" {
  description = "Project in GCP"
}
variable "region" {
  description = "Region of project in GCP"
}
variable "network_name" {
  description = "Network name"
}

variable "site_ms" {
  description = "Server site"
}
# Connection variables
variable "connection_type" {
  description = "Type of connection to VM"
}
variable "ssh_user" {
  default = "rado_pieter"
}
# Master Variables
variable "machine_type_master" {
  description = "Type of GCP VM"
}
variable "vm_image_master" {
  description = "Image used to create VM"
}
variable "vm_disk_size_master" {
  description = "Size of disk on VM"
}
variable "internal_ip_master" {
  description = "Internal IP for salt-master VM"
}
variable "machine_type_minion" {
  description = "Type of GCP VM"
}
variable "vm_image_minion" {
  description = "Image used to create VM"
}
variable "vm_major_release_minion" {
  description = "Major release of VM image"
}
variable "vm_disk_size_minion" {
  description = "Size of disk on VM"
}
variable "internal_ip_minion" {
  description = "Internal IP for salt-master VM"
}
variable "instance_count" {
  description = "Number of instances to launch"
  type = number
}
# SaltStack variables
variable "saltEnv" {
  description = "Environment of saltstack on SaltMaster VM"
}
variable "saltEnvCommon" {
  description = "Environment of saltstack on SaltMaster VM"
}
variable "server_type_ms" {
  description = "Server type - for what will be server used"
}
 variable "component_ms"{
   description = "What component will run on server"
 }  
variable "cluster_ms" {
  description = "Cluster which server belongs to"
}
variable "app_user_ms" {
  description = "User running commands"
}   
variable "saltmaster" {
  description = "DNS for minion config"
}
variable "common_services" {
  description = "Common services install on SaltMaster VM"
}
variable "salt_infra" {
  description = "Salt infra"
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