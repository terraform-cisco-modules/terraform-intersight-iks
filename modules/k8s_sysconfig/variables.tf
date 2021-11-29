variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the K8s sysconfig profile."
}
variable "policy_name" {
  type        = string
  description = "Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built."
}
variable "ntp_servers" {
  type        = list(string)
  description = "NTP Servers to be included in the Network Policy."
}
variable "dns_servers" {
  type        = list(string)
  description = "DNS Servers to be included in the Network Policy."
}
variable "timezone" {
  type        = string
  description = "The timezone of the node's system clock."
}
variable "domain_name" {
  type        = string
  description = "Domain Name information for DNS search."
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}