module "infra_config_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  name             = join("-", [var.cluster_name, "infra-config-policy"])
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
  name             = join("-", [var.cluster_name, "ip-pool"])
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
  policy_name = join("-", [var.cluster_name, "network-policy"])
  dns_servers = [var.ip_primary_dns, var.ip_secondary_dns]
  ntp_servers = [var.ip_primary_dns, var.ip_secondary_dns]
  timezone    = var.timezone
  domain_name = var.domain_name
  org_name    = var.organization
  tags        = var.tags
}

module "trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  policy_name         = join("-", [var.cluster_name, "trusted-registry"])
  unsigned_registries = var.unsigned_registry

  org_name = var.organization
  tags     = var.tags
}

module "k8s_version" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  k8s_version      = join("-", [var.cluster_name, var.version_name])
  k8s_version_name = "1.19.5"

  org_name = var.organization
  tags     = var.tags
}

module "worker_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = join("-", [var.cluster_name, "worker_small"])
  cpu       = 4
  memory    = 163843
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
  source = "terraform-cisco-modules/iks/intersight//modules/cluster"
  name   = join("-", [var.cluster_name, "cluster"])
  # action = "Deploy"
  ip_pool_moid    = module.ip_pool_policy.ip_pool_moid
  load_balancer   = 2
  ssh_key         = var.ssh_key
  ssh_user        = var.ssh_user
  net_config_moid = module.network.network_policy_moid
  sys_config_moid = module.network.sys_config_policy_moid

  org_name = var.organization
  tags     = var.tags
}

module "control_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = join("-", [var.cluster_name, "control-profile"])
  profile_type = "ControlPlane"
  desired_size = 1
  max_size     = 3
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster.cluster_moid
  org_name     = var.organization
  tags         = var.tags
}

module "worker_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = join("-", [var.cluster_name, "worker-profile"])
  profile_type = "Worker"
  desired_size = 1
  max_size     = 50
  ip_pool_moid = module.ip_pool_policy.ip_pool_moid
  version_moid = module.k8s_version.version_policy_moid
  cluster_moid = module.cluster.cluster_moid
  org_name     = var.organization
  tags         = var.tags
}
module "control_provider" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name                     = join("-", [var.cluster_name, "control-provider"])
  instance_type_moid       = module.worker_small.worker_profile_moid
  node_group_moid          = module.control_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  org_name                 = var.organization
  tags                     = var.tags
}
module "prod_vcenter_worker_provider" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name                     = "iks_worker"
  instance_type_moid       = module.k8s_worker_[var.worker_size].worker_profile_moid
  node_group_moid          = module.worker_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  org_name                 = var.organization
  tags                     = var.tags
}