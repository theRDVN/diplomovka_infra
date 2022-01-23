variable "name" {
  description = "Name to be used on all resources as prefix"
  default = "diplomovka"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type = number
  default     = 1
}

variable "saltMaster" {
  description = "Salt master adress"
  default     = "localhost"
}

variable "saltEnv" {
  description = "Salt enviroment to which minions belong"
  default     = "base"
}