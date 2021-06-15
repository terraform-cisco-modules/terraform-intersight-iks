variable "addons" {
  description = "Addons to be created and added to the cluster"
  type = list(object({
    addon_policy_name = string
    addon             = string
    description       = string
    upgrade_strategy  = string
    install_strategy  = string
  }))

}
variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}

variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
