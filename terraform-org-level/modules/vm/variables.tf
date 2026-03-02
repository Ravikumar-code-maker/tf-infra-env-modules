variable "env" {
  type    = string
}

variable "machine_type" {
  type    = string
}

variable "zone" {
  type    = string
}

variable "subnetwork" {
  type    = string
}

variable "metadata" {
  type    = map(string)
}

variable "tags" {
  type    = list(string)
}
