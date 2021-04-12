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
  primary_dns      = var.ip_primary_dns
  secondary_dns    = var.ip_secondary_dns

  org_name = var.organization
  tags     = var.tags
}

module "network" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  policy_name = "${var.cluster_name}-network"
  dns_servers = [var.ip_primary_dns, var.ip_secondary_dns]
  ntp_servers = [var.ip_primary_dns, var.ip_secondary_dns]
  timezone    = var.timezone
  domain_name = var.domain_name
  org_name    = var.organization
  tags        = var.tags
}

module "trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  policy_name         = "${var.cluster_name}-trusted-registry"
  unsigned_registries = var.unsigned_registries

  org_name = var.organization
  tags     = var.tags
}

module "k8s_version" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  k8s_version      = "1.19.5"
  k8s_version_name = "${var.cluster_name}-1.19.5"

  org_name = var.organization
  tags     = var.tags
}

module "worker_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = "${var.cluster_name}-worker-small"
  cpu       = 4
  memory    = 16384
  disk_size = 40

  org_name = var.organization
  tags     = var.tags
}
module "worker_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "worker_medium"])
  cpu       = 8
  memory    = 24576
  disk_size = 60

  org_name = var.organization
  tags     = var.tags
}
module "worker_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "worker_large"])
  cpu       = 12
  memory    = 32768
  disk_size = 80

  org_name = var.organization
  tags     = var.tags
}


module "cluster" {
  source                       = "terraform-cisco-modules/iks/intersight//modules/cluster"
  name                         = "${var.cluster_name}-cluster"
  action                       = var.cluster_action
  wait_for_completion          = var.wait_for_completion
  ip_pool_moid                 = module.ip_pool_policy.ip_pool_moid
  load_balancer                = 2
  ssh_key                      = var.ssh_key
  ssh_user                     = var.ssh_user
  net_config_moid              = module.network.network_policy_moid
  sys_config_moid              = module.network.sys_config_policy_moid
  trusted_registry_policy_moid = module.trusted_registry.trusted_registry_moid

  org_name = var.organization
  tags     = var.tags
}

module "control_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${var.cluster_name}-control"
  profile_type = "ControlPlane"
  desired_size = var.master_count
  max_size     = 3
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster.cluster_moid

}

module "worker_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${var.cluster_name}-worker-profile"
  profile_type = "Worker"
  desired_size = var.worker_count
  max_size     = var.worker_max
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster.cluster_moid

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
  org_name                 = var.organization
  tags                     = var.tags
}
module "worker_provider" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name                     = "${var.cluster_name}-worker-small"
  instance_type_moid       = module.worker_small.worker_profile_moid
  node_group_moid          = module.worker_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  org_name                 = var.organization
  tags                     = var.tags
}