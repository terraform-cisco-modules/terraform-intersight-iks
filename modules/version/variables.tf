variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "iksVersionName" {
  type        = string
  description = "Version name of IKS"
}
variable "policyName" {
  type        = string
  description = "Name of the policy to be created"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the k8s version profile."
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}