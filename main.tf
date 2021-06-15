module "infra_config_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  name             = "${var.cluster_name}-infra-config"
  device_name      = var.vc_target_name
  vc_portgroup     = var.vc_portgroup
  vc_datastore     = var.vc_datastore
  vc_cluster       = var.vc_cluster
  vc_resource_pool = var.vc_resource_pool
  vc_password      = var.vc_password
  org_name         = var.organization
  tags             = var.tags
}

module "ip_pool_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  name             = "${var.cluster_name}-ip-pool"
  starting_address = var.ip_starting_address
  pool_size        = var.ip_pool_size
  netmask          = var.ip_netmask
  gateway          = var.ip_gateway
  primary_dns      = var.dns_servers[0]
  secondary_dns    = length(var.dns_servers) > 1 ? var.dns_servers[1] : null
  org_name         = var.organization
  tags             = var.tags
}

module "network" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  policy_name = "${var.cluster_name}-network"
  dns_servers = var.dns_servers
  ntp_servers = var.ntp_servers
  timezone    = var.timezone
  domain_name = var.domain_name
  org_name    = var.organization
  tags        = var.tags
}


module "trusted_registry" {
  count               = length(var.unsigned_registries) > 0 || length(var.root_ca_registries) > 0 ? 1 : 0
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  policy_name         = "${var.cluster_name}-trusted-registry"
  unsigned_registries = var.unsigned_registries
  root_ca_registries  = var.root_ca_registries
  org_name            = var.organization
  tags                = var.tags
}

module "runtime_policy" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  count                = var.proxy_http_hostname != "" && var.proxy_https_hostname != "" ? 1 : 0
  name                 = "${var.cluster_name}-runtime"
  proxy_http_hostname  = var.proxy_http_hostname
  proxy_https_hostname = var.proxy_https_hostname
  proxy_http_port      = var.proxy_http_port
  proxy_https_port     = var.proxy_https_port
  proxy_http_protocol  = var.proxy_http_protocol
  proxy_https_protocol = var.proxy_https_protocol
  proxy_http_username  = var.proxy_http_username
  proxy_https_username = var.proxy_https_username
  proxy_http_password  = var.proxy_http_password
  proxy_https_password = var.proxy_https_password
  docker_no_proxy      = var.docker_no_proxy
  org_name             = var.organization
  tags                 = var.tags
}

module "k8s_version" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  k8s_version      = var.k8s_version
  k8s_version_name = "${var.cluster_name}-${var.k8s_version}"
  org_name         = var.organization
  tags             = var.tags
}

module "worker_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "small"])
  cpu       = 4
  memory    = 16384
  disk_size = 40
  org_name  = var.organization
  tags      = var.tags
}
module "worker_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "medium"])
  cpu       = 8
  memory    = 24576
  disk_size = 60
  org_name  = var.organization
  tags      = var.tags
}
module "worker_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "large"])
  cpu       = 12
  memory    = 32768
  disk_size = 80
  org_name  = var.organization
  tags      = var.tags
}
module "cluster_profile" {
  source                       = "terraform-cisco-modules/iks/intersight//modules/cluster"
  name                         = var.cluster_name
  action                       = var.cluster_action
  wait_for_completion          = var.wait_for_completion
  ip_pool_moid                 = module.ip_pool_policy.ip_pool_moid
  load_balancer                = var.load_balancers
  ssh_key                      = var.ssh_key
  ssh_user                     = var.ssh_user
  net_config_moid              = module.network.network_policy_moid
  sys_config_moid              = module.network.sys_config_policy_moid
  trusted_registry_policy_moid = length(module.trusted_registry) > 0 ? module.trusted_registry[0].trusted_registry_moid : null
  runtime_policy_moid          = length(module.runtime_policy) > 0 ? module.runtime_policy[0].runtime_policy_moid : null
  org_name                     = var.organization
  tags                         = var.tags
}

module "addons" {

  source   = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addons   = var.addons_list
  org_name = var.organization
  tags     = var.tags
}
module "cluster_addon_profile" {

  source     = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  count      = var.addons_list != null ? 1 : 0
  depends_on = [module.addons]
  # source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  profile_name = "${var.cluster_name}-addon-profile"

  # addons = ["dashboard","monitor"]
  addons       = keys(module.addons.addon_policy)
  cluster_moid = module.cluster_profile.k8s_cluster_moid
  org_name     = var.organization
  tags         = var.tags
}

module "control_profile" {
  source = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  # source = "/Users/jusbarks/github/terraform-intersight-iks/modules/node_profile"
  name         = "${var.cluster_name}-control"
  profile_type = "ControlPlane"
  desired_size = var.master_count
  max_size     = 3
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster_profile.cluster_moid

}

module "worker_profile" {
  source = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  # source = "/Users/jusbarks/github/terraform-intersight-iks/modules/node_profile"
  name         = "${var.cluster_name}-worker_profile"
  profile_type = "Worker"
  desired_size = var.worker_count
  max_size     = var.worker_max
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster_profile.cluster_moid

}
module "control_provider" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${var.cluster_name}-control"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_size == "small"~}${module.worker_small.worker_profile_moid}%{endif~}
  %{if var.worker_size == "medium"~}${module.worker_medium.worker_profile_moid}%{endif~}
  %{if var.worker_size == "large"~}${module.worker_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = module.control_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  tags                     = var.tags
}
module "worker_provider" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${var.cluster_name}-worker"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_size == "small"~}${module.worker_small.worker_profile_moid}%{endif~}
  %{if var.worker_size == "medium"~}${module.worker_medium.worker_profile_moid}%{endif~}
  %{if var.worker_size == "large"~}${module.worker_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = module.worker_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  tags                     = var.tags
}