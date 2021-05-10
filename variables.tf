variable "cluster_name" {
  type        = string
  description = "Name to be given to the cluster.  This will also prefix all attributes created by this module."
}
variable "cluster_action" {
  type        = string
  description = "Cluster action wanted (ex. Deploy or Unassign)"
  default     = "Unassign"
}
variable "vc_target_name" {
  type        = string
  description = "Target name as referenced in Intersight.  vCenter is currently the only supported target."
}
variable "worker_count" {
  type        = number
  description = "Number of worker nodes wanted for the cluster."
  default     = 2
}
variable "load_balancers" {
  type        = number
  description = "Number of load_balancers for the cluster."
  default     = 3
}
variable "worker_max" {
  type        = number
  description = "Maximum number of worker nodes in a cluster."
  default     = 50
}
variable "worker_size" {
  type        = string
  description = "Worker size attribute for worker nodes"
}
variable "master_count" {
  type        = number
  description = "Number of master nodes"
  default     = 1
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
variable "ip_starting_address" {
  type        = string
  description = "Starting IP Address you want for this pool."
}
variable "ip_pool_size" {
  type        = string
  description = "Number of IPs you want this pool to contain."
}
variable "ip_netmask" {
  type        = string
  description = "Subnet Mask for this pool."
}
variable "ip_gateway" {
  type        = string
  description = "Default gateway for this pool."
}
variable "ip_primary_dns" {
  type        = string
  description = "Primary DNS Server for this pool."
}
variable "ip_secondary_dns" {
  type        = string
  description = "Secondary DNS Server for this pool."
  default     = ""
}
variable "ip_primary_ntp" {
  type        = string
  description = "Primary NTP Server for this pool."
}
variable "ip_secondary_ntp" {
  type        = string
  description = "Secondary NTP Server for this pool."
  default     = ""
}
variable "timezone" {
  type        = string
  description = "The timezone of the node's system clock.  Check Terraform documentation for correct format.  Example America/New_York"
}
variable "domain_name" {
  type        = string
  description = "Domain Name information for DNS search."
}
variable "pod_cidr" {
  type        = string
  description = "Pod CIDR Block to be used to assign POD IP Addresses."
  default     = "100.65.0.0/16"
}
variable "service_cidr" {
  type        = string
  description = "Service CIDR Block used to assign cluster service IP addresses."
  default     = "100.64.0.0/24"
}
variable "cni" {
  type        = string
  description = "Supported CNI type. Currently we only support Calico.* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin."
  default     = "Calico"
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
  type    = list(map(string))
  default = []
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
