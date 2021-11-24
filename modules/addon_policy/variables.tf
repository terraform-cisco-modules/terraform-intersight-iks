variable "addon" {
  type = object({
    policyName       = string
    addonName        = string
    description      = optional(string)
    upgradeStrategy  = optional(string)
    installStrategy  = optional(string)
    overrideSets     = optional(list(map(string)))
    overrides        = optional(string)
    releaseName      = optional(string)
    releaseNamespace = optional(string)
    releaseVersion   = string
  })

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
