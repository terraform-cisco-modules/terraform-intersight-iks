
variable "org_name" {
  type        = string
  description = "Intersight Organization name"
  default     = "default"
}
variable "device_name" {
  type        = string
  description = "Name of the Virtual Machine Provider you wish to add.  i.e vCenter"
}
variable "name" {
  type        = string
  description = "Name of the Infrastructure Provider to be created"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the infrastructure configuration policy"
}
variable "vc_cluster" {
  type        = string
  description = "Name of the cluster you wish to make part of this provider within vCenter."
}
variable "vc_portgroup" {
  type        = list(string)
  description = "Name of the portgroup(s) to be used in this provider"
}
variable "vc_datastore" {
  type        = string
  description = "Name of the datastore to be used with this provider."
}
variable "vc_password" {
  sensitive   = true
  type        = string
  description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
}
variable "vc_resource_pool" {
  type        = string
  description = "Name of the resource pool to be used with this provider."
  default     = ""
}

variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
