variable "name" {
  description = "Name of DNS Zone"
  default ="pieterr-net"
}
variable "dns_name" {
  description = "DNS Name of pieterr.net"
  default = "pieterr.net."
}
variable "project" {
  description = "Project in GCP"
  default = "diplomovka-334621" # OLD def= diplomovka-334620
}
variable "visibility" {
  description = "Visibility of DNS zone"
  default = "public"
}
variable "description" {
  description = "Description of DNS managed zone pieterr.net"
  default = "DNS zone for domain: pieterr.net"
}