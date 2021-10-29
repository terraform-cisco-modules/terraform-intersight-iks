
variable "org_name" {
  type        = string
  description = "Intersight Organization name"
  default     = "default"
}
variable "vmConfig" {
  type = object({
    platformType       = string
    targetName         = string
    policyName         = string
    description        = optional(string)
    interfaces         = list(string)
    diskMode           = optional(string)
    vcTargetName       = optional(string)
    vcClusterName      = optional(string)
    vcDatastoreName    = optional(string)
    vcResourcePoolName = optional(string)
    vcPassword         = optional(string)
  })
  sensitive = true
}

variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
