variable "name" {
  type        = string
  description = "Name of the Infrastructure Provider to be created"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the infrastructure provider policy"
}
# variable "vc_cluster" {
#   type        = string
#   description = "Name of the cluster you wish to make part of this provider within vCenter."
# }
# variable "vc_portgroup" {
#   type        = list(string)
#   description = "Name of the portgroup(s) to be used in this provider"
# }
# variable "vc_datastore" {
#   type        = string
#   description = "Name of the datastore to be used with this provider."
# }
# variable "vc_password" {
#   sensitive   = true
#   type        = string
#   description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
# }
# variable "vc_resource_pool" {
#   type        = string
#   description = "Name of the resource pool to be used with this provider."
#   default     = ""
# }
variable "instance_type_moid" {
  type        = string
  description = "MOID of the Instance type mapped to this provider"
  default     = ""
}
variable "node_group_moid" {
  type        = string
  description = "MOID of the Node Group mapped to this provider"
  default     = ""
}
variable "infra_config_policy_moid" {
  type        = string
  description = "MOID of the Infra Config Policy mapped to this provider"
  default     = ""
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
