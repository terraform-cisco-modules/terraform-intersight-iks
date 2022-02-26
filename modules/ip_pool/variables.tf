variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the IP Pool Policy."
  nullable    = false
}
variable "name" {
  type        = string
  description = "Name of the IP Pool to be created."
}
variable "starting_address" {
  type        = string
  description = "Starting IP Address you want for this pool."
}
variable "pool_size" {
  type        = string
  description = "Number of IPs you want this pool to contain."
}
variable "ending_address" {
  type        = string
  description = "Ending IP Address you want for this pool."
  default     = null
}
variable "netmask" {
  type        = string
  description = "Subnet Mask for this pool."
}
variable "gateway" {
  type        = string
  description = "Default gateway for this pool."
}
variable "primary_dns" {
  type        = string
  description = "Primary DNS Server for this pool."
}
variable "secondary_dns" {
  type        = string
  description = "Secondary DNS Server for this pool."
  default     = ""
  nullable    = false
}

variable "tags" {
  type    = list(map(string))
  default = []
}