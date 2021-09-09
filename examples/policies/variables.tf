variable "apikey" {
  type        = string
  description = "API Key"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
}
variable "vc_password" {
  type        = string
  description = "vCenter Password"
}
variable "tags" {
  type    = list(map(string))
  default = []
}

