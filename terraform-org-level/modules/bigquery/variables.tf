variable "datasets" {
  type   = map(object({
    location = string
    tables   = list(string)
  }))
}
