variable "saltEnv" {
  description = "Salt environment to which created minions will belong"
  default     = "base"
}

variable "saltMaster" {
  description = "IP or hostname of existing saltmaster"
  default     = "diplomovka-ops"
}

variable "instanceCount" {
  description = "Number of instances created"
  default     = "1"
}