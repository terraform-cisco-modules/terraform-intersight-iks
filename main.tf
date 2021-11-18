
#Importing existing components if they exist.
data "intersight_kubernetes_virtual_machine_infra_config_policy" "this" {
  count = var.infraConfigPolicy.use_existing == true ? 1 : 0
  name  = var.infraConfigPolicy.policyName
}
data "intersight_ippool_pool" "this" {
  count = var.ip_pool.use_existing == true ? 1 : 0
  name  = var.ip_pool.name
}
data "intersight_kubernetes_network_policy" "this" {
  count = var.k8s_network.use_existing == true ? 1 : 0
  name  = var.k8s_network.name
}
data "intersight_kubernetes_sys_config_policy" "this" {
  count = var.sysconfig.use_existing == true ? 1 : 0
  name  = var.sysconfig.name
}
data "intersight_kubernetes_trusted_registries_policy" "this" {
  count = var.tr_policy.use_existing == true ? 1 : 0
  name  = var.tr_policy.name
}
data "intersight_kubernetes_container_runtime_policy" "this" {
  count = var.runtime_policy.use_existing == true ? 1 : 0
  name  = var.runtime_policy.name
}
data "intersight_kubernetes_version_policy" "this" {
  count = var.version_policy.use_existing == true ? 1 : 0
  name  = var.version_policy.name
}
data "intersight_kubernetes_virtual_machine_instance_type" "this" {
  count = var.instance_type.use_existing == true ? 1 : 0
  name  = var.instance_type.name
}

module "infra_config_policy" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  count  = var.infraConfigPolicy.use_existing == true ? 0 : 1
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

  org_name = var.organization
  tags     = var.tags
}
module "ip_pool_policy" {
  count            = var.ip_pool.use_existing == true ? 0 : 1
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
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
module "k8s_network" {
  source       = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  count        = var.k8s_network.use_existing == true ? 0 : 1
  policy_name  = var.k8s_network.name
  pod_cidr     = var.k8s_network.pod_cidr
  service_cidr = var.k8s_network.service_cidr
  cni          = var.k8s_network.cni
  org_name     = var.organization
  tags         = var.tags
}
module "k8s_sysconfig" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig"
  count       = var.sysconfig.use_existing == true ? 0 : 1
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
  count               = var.tr_policy.create_new == true ? 1 : 0
  policy_name         = var.tr_policy.name
  unsigned_registries = var.tr_policy.unsigned_registries
  root_ca_registries  = var.tr_policy.root_ca_registries
  org_name            = var.organization
  tags                = var.tags
}
module "runtime_policy" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  count                = var.runtime_policy.create_new == true ? 1 : 0
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
module "k8s_version" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  count            = var.version_policy.use_existing == true ? 0 : 1
  k8s_version      = var.version_policy.version
  k8s_version_name = var.version_policy.name
  org_name         = var.organization
  tags             = var.tags
}
module "instance_type" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  count     = var.instance_type.use_existing == true ? 0 : 1
  name      = var.instance_type.name
  cpu       = var.instance_type.cpu
  memory    = var.instance_type.memory
  disk_size = var.instance_type.disk_size
  org_name  = var.organization
  tags      = var.tags
}
module "cluster_profile" {
  source              = "terraform-cisco-modules/iks/intersight//modules/cluster"
  name                = var.cluster.name
  action              = var.cluster.action
  wait_for_completion = var.cluster.wait_for_completion
  ip_pool_moid        = var.ip_pool.use_existing == true ? data.intersight_ippool_pool.this.0.results.0.moid : module.ip_pool_policy.0.ip_pool_moid
  load_balancer       = var.cluster.load_balancers
  ssh_key             = var.cluster.ssh_public_key
  ssh_user            = var.cluster.ssh_user
  net_config_moid     = var.k8s_network.use_existing == true ? data.intersight_kubernetes_network_policy.this.0.results.0.moid : module.k8s_network.0.network_policy_moid
  sys_config_moid     = var.sysconfig.use_existing == true ? data.intersight_kubernetes_sys_config_policy.this.0.results.0.moid : module.k8s_sysconfig.0.sys_config_policy_moid
  # trusted_registry_policy_moid = var.tr_policy.use_existing == true ? data.intersight_kubernetes_trusted_registries_policy.this.0.results.0.moid : module.trusted_registry.0.trusted_registry_moid
  trusted_registry_policy_moid = trimspace(<<-EOT
  %{if var.tr_policy.use_existing == false && var.tr_policy.create_new == false~}%{endif~}
  %{if var.tr_policy.use_existing == true && var.tr_policy.create_new == false~}${data.intersight_kubernetes_trusted_registries_policy.this.0.results.0.moid}%{endif~}
  %{if var.tr_policy.use_existing == true && var.tr_policy.create_new == true~}%{endif~}
  %{if var.tr_policy.use_existing == false && var.tr_policy.create_new == true~}${module.trusted_registry.0.trusted_registry_moid}%{endif~}
  EOT
  )
  # runtime_policy_moid          = var.runtime_policy.use_existing == true ? data.intersight_kubernetes_container_runtime_policy.this.0.results.0.moid : module.runtime_policy.0.runtime_policy_moid
  runtime_policy_moid = trimspace(<<-EOT
  %{if var.runtime_policy.use_existing == false && var.runtime_policy.create_new == false~}%{endif~}
  %{if var.runtime_policy.use_existing == true && var.runtime_policy.create_new == false~}${data.intersight_kubernetes_container_runtime_policy.this.0.results.0.moid}%{endif~}
  %{if var.runtime_policy.use_existing == true && var.runtime_policy.create_new == true~}%{endif~}
  %{if var.runtime_policy.use_existing == false && var.runtime_policy.create_new == true~}${module.runtime_policy.0.runtime_policy_moid}%{endif~}
  EOT
  )
  org_name = var.organization
  tags     = var.tags
}
module "addons" {

  source   = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addons   = var.addons_list
  org_name = var.organization
  tags     = var.tags
}
module "cluster_addon_profile" {

  source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  count        = var.addons_list != null ? 1 : 0
  depends_on   = [module.addons]
  profile_name = "${var.cluster.name}-addon-profile"

  addons       = keys(module.addons.addon_policy)
  cluster_moid = module.cluster_profile.k8s_cluster_moid
  org_name     = var.organization
  tags         = var.tags
}
module "control_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${var.cluster.name}-control_profile"
  profile_type = "ControlPlane"
  min_size     = var.cluster.control_nodes
  max_size     = var.cluster.control_nodes + 1
  ip_pool_moid = var.ip_pool.use_existing == true ? data.intersight_ippool_pool.this.0.results.0.moid : module.ip_pool_policy.0.ip_pool_moid
  version_moid = var.version_policy.use_existing == true ? data.intersight_kubernetes_version_policy.this.0.results.0.moid : module.k8s_version.0.version_policy_moid
  cluster_moid = module.cluster_profile.cluster_moid

}
module "worker_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${var.cluster.name}-worker_profile"
  profile_type = "Worker"
  min_size     = var.cluster.worker_nodes
  max_size     = var.cluster.worker_max
  ip_pool_moid = var.ip_pool.use_existing == true ? data.intersight_ippool_pool.this.0.results.0.moid : module.ip_pool_policy.0.ip_pool_moid
  version_moid = var.version_policy.use_existing == true ? data.intersight_kubernetes_version_policy.this.0.results.0.moid : module.k8s_version.0.version_policy_moid
  cluster_moid = module.cluster_profile.cluster_moid

}
module "control_provider" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name                     = "${var.cluster.name}-control_provider"
  instance_type_moid       = var.instance_type.use_existing == true ? data.intersight_kubernetes_virtual_machine_instance_type.this.0.results.0.moid : module.instance_type.0.moid
  node_group_moid          = module.control_profile.node_group_profile_moid
  infra_config_policy_moid = var.infraConfigPolicy.use_existing == true ? data.intersight_kubernetes_virtual_machine_infra_config_policy.this.0.results.0.moid : module.infra_config_policy.0.infra_config_moid
  tags                     = var.tags
}
module "worker_provider" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name                     = "${var.cluster.name}-worker_provider"
  instance_type_moid       = var.instance_type.use_existing == true ? data.intersight_kubernetes_virtual_machine_instance_type.this.0.results.0.moid : module.instance_type.0.moid
  node_group_moid          = module.worker_profile.node_group_profile_moid
  infra_config_policy_moid = var.infraConfigPolicy.use_existing == true ? data.intersight_kubernetes_virtual_machine_infra_config_policy.this.0.results.0.moid : module.infra_config_policy.0.infra_config_moid
  tags                     = var.tags
}