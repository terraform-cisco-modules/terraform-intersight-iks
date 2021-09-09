variable "version_policy" {
  type = object({
    use_existing = bool
    name         = string
    version      = optional(string)
  })
}
variable "infra_config_policy" {
  type = object({
    use_existing     = bool
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
variable "instance_type" {
  type = object({
    use_existing = bool
    name         = string
    cpu          = optional(number)
    memory       = optional(number)
    disk_size    = optional(number)
  })
}
variable "cluster" {
  type = object({
    name                = string
    action              = string
    wait_for_completion = bool
    worker_nodes        = number
    load_balancers      = number
    worker_max          = number
    control_nodes       = number
    ssh_user            = string
    ssh_public_key      = string
  })
}
variable "runtime_policy" {
  type = object({
    use_existing         = bool
    create_new           = bool
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
variable "infra_config_policy_name" {
  type        = string
  description = "Name of existing infra config policy (if it exists) to be used."
  default     = ""
}
variable "k8s_network_policy_name" {
  type        = string
  description = "Name of existing K8s Network Policy (if it exists) to be used."
  default     = ""
}
variable "addons_list" {
  type = list(object({
    addon_policy_name = string
    addon             = string
    description       = string
    upgrade_strategy  = string
    install_strategy  = string
  }))
  description = "List of objects for each addon to be added."
  default     = []
}
variable "ip_pool" {
  type = object({
    use_existing        = bool
    name                = string
    ip_starting_address = optional(string)
    ip_pool_size        = optional(string)
    ip_netmask          = optional(string)
    ip_gateway          = optional(string)
    dns_servers         = optional(list(string))
  })
}
variable "k8s_network" {
  type = object({
    use_existing = bool
    name         = optional(string)
    pod_cidr     = optional(string)
    service_cidr = optional(string)
    cni          = optional(string)
  })
}
variable "tr_policy" {
  type = object({
    use_existing        = bool
    create_new          = bool
    name                = string
    root_ca_registries  = optional(list(string))
    unsigned_registries = optional(list(string))
  })
}
variable "sysconfig" {
  type = object({
    use_existing = bool
    name         = string
    ntp_servers  = optional(list(string))
    dns_servers  = optional(list(string))
    timezone     = optional(string)
    domain_name  = optional(string)
  })
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