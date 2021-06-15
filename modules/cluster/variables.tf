variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "name" {
  type        = string
  description = "Name of the IKS Cluster to be deployed."
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the cluster profile."
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
variable "wait_for_completion" {
  type        = bool
  default     = false
  description = "Wait for cluster completion true/false"
}
variable "runtime_policy_moid" {
  type        = string
  description = "MOID for the Runtime Policy that is being consumed."
  default     = ""
}
variable "trusted_registry_policy_moid" {
  type        = string
  description = "MOID for the Trusted Registry Policy that is being consumed."
  default     = ""
}

variable "net_config_moid" {
  type        = string
  description = "MOID for the Network Config Policy that is being consumed."
}

variable "sys_config_moid" {
  type        = string
  description = "MOID for the System Config Policy that is being consumed."
}


variable "action" {
  type        = string
  description = "Action for cluster. i.e 'Deploy' 'Unassign'"
  default     = "Unassign"
}


variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}