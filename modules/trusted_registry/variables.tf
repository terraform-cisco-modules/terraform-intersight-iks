variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the trusted registry profile."
  nullable    = false
}

variable "policy_name" {
  type        = string
  description = "Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built."
}

variable "root_ca_registries" {
  type        = list(string)
  description = "List of root CA certificates."
  default     = []
  nullable    = false
}
variable "unsigned_registries" {
  type        = list(string)
  description = "List of unsigned registries to be supported."
  default     = []
  nullable    = false
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}