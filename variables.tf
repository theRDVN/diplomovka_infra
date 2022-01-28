# Common variables
variable "name" {
  description = "Name to be used on all resources as prefix"
  default = "diplomovka"
}
variable "zone" {
  description = "Zone where is VM located"
  default = "europe-west1-b"
}
variable "project" {
  description = "Project in GCP"
  default = "diplomovka-334620"
}
variable "network_name" {
  description = "Network name"
  default = "default"
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
# Master Variables
variable "machine_type_master" {
  description = "Type of GCP VM"
  default = "e2-medium"
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
  default = "10.132.0.3"
}
variable "machine_type_minion" {
  description = "Type of GCP VM"
  default = "e2-medium"
}
variable "vm_image_minion" {
  description = "Image used to create VM"
  default = "centos-cloud/centos-8"
}
variable "vm_disk_size_minion" {
  description = "Size of disk on VM"
  default = "20"
}
variable "internal_ip_minion" {
  description = "Internal IP for salt-master VM"
  default = "10.132.0.4"
}
variable "instance_count" {
  description = "Number of instances to launch"
  type = number
  default     = 1
}
# SaltStack variables
variable "saltEnv" {
  description = "Environment of saltstack on SaltMaster VM"
  default = "base"
}
variable "saltEnvCommon" {
  description = "Environment of saltstack on SaltMaster VM"
  default = "common"
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
variable "saltmaster" {
  description = "DNS for minion config"
  default = "localhost"
}
variable "common_services" {
  description = "Common services install on SaltMaster VM"
  default = ["stackstorm", "saltmaster", "saltapi"]
}
variable "salt_infra" {
  description = "Salt infra"
  default = ["master"]
}