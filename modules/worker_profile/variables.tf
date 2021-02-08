variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "instance_type" {
  type = list(object({
    name   = string,
    cpu    = number,
    memory = number,
    disk   = string
  }))
}
variable "tags" {
  type    = list(map(string))
  default = []
}