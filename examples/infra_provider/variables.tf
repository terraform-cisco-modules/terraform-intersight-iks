variable "api_key" {
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
  default     = "default"
}

variable "vc_password" {
  sensitive   = true
  type        = string
  description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
}

# variable "addon" {
#   # Current available addons check documentation for updates
#   # kubernetes-dashboard
#   # CCP-Monitor
#   # EFK
#   type    = string
# }
# variable "upgrade_strategy" {
#   # Available Upgrade Strategies
#   # UpgradeOnly
#   type    = string
# }

# variable "addon_policy_name" {
#   type        = string
#   description = "Addon Policy Name"
# }

# variable "network_policy_list" {
#   type = list(object({
#     name                       = string
#     network_pod_cidr_block     = string
#     network_service_cidr_block = string
#     ntp                        = list(string)
#     dns                        = list(string)
#     timezone                   = string
#     domain_name                = string
#   }))
# }

# variable "instance_type" {
#   type = list(object({
#     name   = string,
#     cpu    = number,
#     memory = number,
#     disk   = string
#   }))
# }
# variable "ip_pool_list" {
#   type    = list(map(string))
#   default = []
# }

# variable "k8s_version_list" {
#   type = list(object({
#     name    = string,
#     version = string
#   }))
# }


# variable "infra_list" {
#   # sensitive = true
#   type = list(object({
#     name          = string
#     device_name   = string
#     cluster       = string
#     interfaces    = list(string)
#     datastore     = string
#     passphrase    = string
#     resource_pool = string

#   }))
# }

variable "tags" {
  type    = list(map(string))
  default = []
}