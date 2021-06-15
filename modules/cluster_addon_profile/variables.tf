variable "addons" {
  type        = list(string)
  default     = []
  description = "List of addons to be added to the policy."
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