variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "name" {
  type        = string
  description = "Name of the IP Pool to be created."
}
variable "starting_address" {
  type        = string
  description = "Starting IP Address you want for this pool."
  # validation {
  #   condition = can(regex("^(?:[0-9]{1,3}.){3}[0-9]{1,3}$"))
  #   error_message = "Must be a valid IP Address X.X.X.X"
  # }
}
variable "pool_size" {
  type        = string
  description = "Number of IPs you want this pool to contain."
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
}

variable "tags" {
  type    = list(map(string))
  default = []
}