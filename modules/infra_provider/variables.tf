variable "name" {
  type        = string
  description = "Name of the Infrastructure Provider to be created"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the infrastructure provider policy"
  nullable    = false
}
variable "instance_type_moid" {
  type        = string
  description = "MOID of the Instance type mapped to this provider"
  default     = ""
  nullable    = false
}
variable "node_group_moid" {
  type        = string
  description = "MOID of the Node Group mapped to this provider"
  default     = ""
  nullable    = false
}
variable "infra_config_policy_moid" {
  type        = string
  description = "MOID of the Infra Config Policy mapped to this provider"
  default     = ""
  nullable    = false
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
