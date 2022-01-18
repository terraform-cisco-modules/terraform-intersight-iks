
variable "addons" {
  type = list(object({
    addonPolicyName  = string
    addonName        = string
    description      = optional(string)
    upgradeStrategy  = optional(string)
    installStrategy  = optional(string)
    overrideSets     = optional(list(map(string)))
    overrides        = optional(string)
    releaseName      = optional(string)
    releaseNamespace = optional(string)
    releaseVersion   = optional(string)
  }))
}

variable "profile_name" {
  type        = string
  description = "Name of the Cluster Addon Policy"
}
variable "cluster_moid" {
  type        = string
  description = "MOID of the cluster to be associated with this cluster addon profile."
  default     = ""
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