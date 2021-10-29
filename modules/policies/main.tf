
module "k8s_version" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  version          = ">=2.0.3"
  count            = var.version_policy.create == true ? 1 : 0
  k8s_version_name = var.version_policy.name
  k8s_version      = var.version_policy.version
  org_name         = var.organization
  tags             = var.tags
}


module "infra_config_policy" {
  version = ">=2.0.3"
  source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  count   = var.infraConfigPolicy.create == true ? 1 : 0
  vmConfig = {
    platformType       = var.infraConfigPolicy.platformType
    targetName         = var.infraConfigPolicy.targetName
    policyName         = var.infraConfigPolicy.policyName
    description        = var.infraConfigPolicy.description
    interfaces         = var.infraConfigPolicy.interfaces
    vcTargetName       = var.infraConfigPolicy.vcTargetName
    vcClusterName      = var.infraConfigPolicy.vcClusterName
    vcDatastoreName    = var.infraConfigPolicy.vcDatastoreName
    vcResourcePoolName = var.infraConfigPolicy.vcResourcePoolName
    vcPassword         = var.infraConfigPolicy.vcPassword
  }
}
module "instance_type" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  version   = ">=2.0.3"
  count     = var.instance_type.create == true ? 1 : 0
  name      = var.instance_type.name
  cpu       = var.instance_type.cpu
  memory    = var.instance_type.memory
  disk_size = var.instance_type.disk_size
  org_name  = var.organization
  tags      = var.tags
}
module "k8s_network" {
  source       = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  version      = ">=2.0.3"
  count        = var.k8s_network.create == true ? 1 : 0
  policy_name  = var.k8s_network.name
  pod_cidr     = var.k8s_network.pod_cidr
  service_cidr = var.k8s_network.service_cidr
  cni          = var.k8s_network.cni
  org_name     = var.organization
  tags         = var.tags
}

module "ip_pool_policy" {
  count            = var.ip_pool.create == true ? 1 : 0
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  version          = ">=2.0.3"
  name             = var.ip_pool.name
  starting_address = var.ip_pool.ip_starting_address
  pool_size        = var.ip_pool.ip_pool_size
  netmask          = var.ip_pool.ip_netmask
  gateway          = var.ip_pool.ip_gateway
  primary_dns      = var.ip_pool.dns_servers[0]
  secondary_dns    = length(var.ip_pool.dns_servers) > 1 ? var.ip_pool.dns_servers[1] : null
  org_name         = var.organization
  tags             = var.tags
}
module "k8s_sysconfig" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig"
  version     = ">=2.0.3"
  count       = var.sysconfig.create == true ? 1 : 0
  policy_name = var.sysconfig.name
  dns_servers = var.sysconfig.dns_servers
  ntp_servers = var.sysconfig.ntp_servers
  timezone    = var.sysconfig.timezone
  domain_name = var.sysconfig.domain_name
  org_name    = var.organization
  tags        = var.tags
}
module "trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  version             = ">=2.0.3"
  count               = var.tr_policy.create == true ? 1 : 0
  policy_name         = var.tr_policy.name
  unsigned_registries = var.tr_policy.unsigned_registries
  root_ca_registries  = var.tr_policy.root_ca_registries
  org_name            = var.organization
  tags                = var.tags
}

module "runtime_policy" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  version              = ">=2.0.3"
  count                = var.runtime_policy.create == true ? 1 : 0
  name                 = var.runtime_policy.name
  proxy_http_hostname  = var.runtime_policy.http_proxy_hostname
  proxy_http_port      = var.runtime_policy.http_proxy_port
  proxy_http_protocol  = var.runtime_policy.http_proxy_protocol
  proxy_http_username  = var.runtime_policy.http_proxy_username
  proxy_http_password  = var.runtime_policy.http_proxy_password
  proxy_https_hostname = var.runtime_policy.https_proxy_hostname
  proxy_https_port     = var.runtime_policy.https_proxy_port
  proxy_https_protocol = var.runtime_policy.https_proxy_protocol
  proxy_https_username = var.runtime_policy.https_proxy_username
  proxy_https_password = var.runtime_policy.https_proxy_password
  docker_no_proxy      = var.runtime_policy.docker_no_proxy
  org_name             = var.organization
  tags                 = var.tags
}
