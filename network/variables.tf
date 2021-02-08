variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}

variable "ip_pool_list" {
  type    = list(map(string))
  default = []
}

variable "tags" {
  type    = list(map(string))
  default = []
}