variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "name" {
  type        = string
  description = "Name of the IKS Cluster to be deployed."
}

variable "ip_pool_moid" {
  type        = string
  description = "MOID derived from the IP Pool that is being consumed."
}

variable "load_balancer" {
  type        = number
  description = "Number of load balancer addresses to deploy."
}

variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
}
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}

variable "addon_policy_moid" {
  type        = string
  description = "MOID derived from the Addon Policy that is being consumed."
}

variable "trusted_registry_policy_moid" {
  type        = string
  description = "MOID derived from the Trusted Registry Policy that is being consumed."
}

variable "net_config_moid" {
  type        = string
  description = "MOID derived from the Network Config Policy that is being consumed."
}

variable "sys_config_moid" {
  type        = string
  description = "MOID derived from the System Config Policy that is being consumed."
}

variable "action" {
  type        = string
  description = "Ation for cluster. i.e 'Deploy' 'Unassign'"
  default     = ""
}


variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}