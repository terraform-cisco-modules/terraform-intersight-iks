variable "versionPolicy" {
  type = object({
    useExisting = bool
    policyName  = string
    description = optional(string)
    versionName = optional(string)
  })
}
variable "infraConfigPolicy" {
  type = object({
    use_existing       = bool
    platformType       = optional(string)
    targetName         = optional(string)
    policyName         = string
    description        = optional(string)
    interfaces         = optional(list(string))
    diskMode           = optional(string)
    vcTargetName       = optional(string)
    vcClusterName      = optional(string)
    vcDatastoreName    = optional(string)
    vcResourcePoolName = optional(string)
    vcPassword         = optional(string)
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
variable "addons" {
  type = list(object({
    createNew        = bool
    addonPolicyName  = optional(string)
    addonName        = optional(string)
    description      = optional(string)
    upgradeStrategy  = optional(string)
    installStrategy  = optional(string)
    overrideSets     = optional(list(map(string)))
    overrides        = optional(string)
    releaseName      = optional(string)
    releaseNamespace = optional(string)
    releaseVersion   = optional(string)
  }))
  default = []
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
    name                = optional(string)
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