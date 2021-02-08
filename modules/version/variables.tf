variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}

variable "k8s_version_list" {
  type = list(object({
    name    = string,
    version = string
  }))
}
variable "tags" {
  type    = list(map(string))
  default = []
}