variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "name" {
  type        = string
  description = "Name of the Container Runtime Policy to be created."
}

variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the addon policy"
}
variable "docker_bridge_cidr" {
  type        = string
  default     = ""
  description = "Docker Bridge CIDR network to be specified."
}
variable "proxy_http_hostname" {
  type        = string
  description = "HTTP Proxy server FQDN or IP."
}
variable "proxy_http_password" {
  type        = string
  default     = ""
  description = "The password for the HTTP Proxy."
}
variable "proxy_http_username" {
  type        = string
  default     = ""
  description = "The username for the HTTP Proxy."
}
variable "proxy_http_port" {
  type        = number
  default     = 8080
  description = "The HTTP Proxy port number.The port number of the HTTP proxy must be between 1 and 65535, inclusive."
}
variable "proxy_http_protocol" {
  type        = string
  default     = "http"
  description = " Protocol to use for the HTTPS Proxy."
}
variable "proxy_https_hostname" {
  type        = string
  description = "HTTPS Proxy server FQDN or IP."
}
variable "proxy_https_password" {
  type        = string
  default     = ""
  description = "The password for the HTTPS Proxy."
}
variable "proxy_https_username" {
  type        = string
  default     = ""
  description = "The username for the HTTPS Proxy."
}
variable "proxy_https_port" {
  type        = number
  default     = 8443
  description = "The HTTPS Proxy port number.The port number of the HTTPS proxy must be between 1 and 65535, inclusive."
}
variable "proxy_https_protocol" {
  type        = string
  default     = "https"
  description = " Protocol to use for the HTTPS Proxy."
}
variable "docker_no_proxy" {
  type        = list(string)
  default     = []
  description = "Networks excluded from the proxy."
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}


