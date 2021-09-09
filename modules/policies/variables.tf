variable "version_policy" {
  type = object({
    create  = bool
    name    = string
    version = optional(string)
  })
}
variable "infra_config_policy" {
  type = object({
    create           = bool
    name             = optional(string)
    vc_target_name   = optional(string)
    vc_cluster       = optional(string)
    vc_portgroups    = optional(list(string))
    vc_datastore     = optional(string)
    vc_resource_pool = optional(string)
    vc_password      = optional(string)
  })
  sensitive = true
}
variable "k8s_network" {
  type = object({
    create       = bool
    name         = optional(string)
    pod_cidr     = optional(string)
    service_cidr = optional(string)
    cni          = optional(string)
  })
}
variable "runtime_policy" {
  type = object({
    create               = bool
    name                 = optional(string)
    http_proxy_hostname  = optional(string)
    http_proxy_port      = optional(number)
    http_proxy_protocol  = optional(string)
    http_proxy_username  = optional(string)
    http_proxy_password  = optional(string)
    https_proxy_hostname = optional(string)
    https_proxy_port     = optional(number)
    https_proxy_protocol = optional(string)
    https_proxy_username = optional(string)
    https_proxy_password = optional(string)
    docker_no_proxy      = optional(list(string))
  })
  sensitive = true
}
variable "instance_type" {
  type = object({
    create    = bool
    name      = string
    cpu       = optional(number)
    memory    = optional(number)
    disk_size = optional(number)
  })
}
variable "ip_pool" {
  type = object({
    create              = bool
    name                = string
    ip_starting_address = optional(string)
    ip_pool_size        = optional(string)
    ip_netmask          = optional(string)
    ip_gateway          = optional(string)
    dns_servers         = optional(list(string))
  })
}

variable "tr_policy" {
  type = object({
    create              = bool
    name                = string
    root_ca_registries  = optional(list(string))
    unsigned_registries = optional(list(string))
  })
}
variable "sysconfig" {
  type = object({
    create      = bool
    name        = string
    ntp_servers = optional(list(string))
    dns_servers = optional(list(string))
    timezone    = optional(string)
    domain_name = optional(string)
  })
}
variable "tags" {
  type    = list(map(string))
  default = []
}
variable "organization" {
  type        = string
  description = "Organization Name"
}
