variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "k8s_version" {
  type        = string
  description = "Version of the Kubernetes cluster"
}
variable "k8s_version_name" {
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