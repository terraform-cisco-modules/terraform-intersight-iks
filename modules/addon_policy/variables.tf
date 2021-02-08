variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "addon_policy_name" {
  type        = string
  description = "Name of the Addon Policy to be created."
}
variable "addons" {
  type        = list(string)
  default     = []
  description = "List of addons to be added to the policy."
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}