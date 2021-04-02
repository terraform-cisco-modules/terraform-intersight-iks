variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}

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
variable "desired_size" {
  type        = number
  description = "Desired size for node profile.  For master profiles values an be 1 or 3"
  default     = 1
}
variable "max_size" {
  type        = number
  description = "Maximum size for node profile."
  default     = 1
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