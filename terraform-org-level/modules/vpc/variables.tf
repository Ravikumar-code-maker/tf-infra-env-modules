variable "network_name" {
  type  = string
}

variable "subnet_cidr" {
  type  = string
}

variable "region" {
  tyep  = string
}

variable "firewall_rules" {
  type          = list(object({
  name          : string
  network       : string
  allow         : list(object({ protocol : string, ports : list(string) }))
  source_ranges : list(string)
  }))
}
