variable "name" {
  type        = string
  description = "Name of the Node Profile to be created."
}
variable "description" {
  type        = string
  description = "Descripton of the Node Profile."
  default     = ""
}

variable "profile_type" {
  type        = string
  description = "Type of profile to be created. i.e Master or Worker"
  default     = ""
}
variable "min_size" {
  type        = number
  description = "Minimum size for node profile."
}
variable "max_size" {
  type        = number
  description = "Maximum size for node profile."
}

variable "ip_pool_moid" {
  type        = string
  description = "MOID derived from the IP Pool that is being consumed."
}
variable "version_moid" {
  type        = string
  description = "MOID derived from the Version Policy that is being consumed."
}
variable "cluster_moid" {
  type        = string
  description = "MOID derived from the Cluster that is being consumed."
}
variable "tags" {
  type    = list(map(string))
  default = []
}