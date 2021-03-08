variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}


variable "policy_name" {
  type        = string
  description = "Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built."
}

variable "root_ca_registries" {
  type        = list(string)
  description = "List of root CA certificates."
  default     = []
}
variable "unsigned_registries" {
  type        = list(string)
  description = "List of unsigned registries to be supported."
  default     = []
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}