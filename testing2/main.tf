provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "iks_addon_dashboard" {

  source            = "../modules/addon_policy"
  addon_policy_name = "dashboard"
  addons            = "kubernetes-dashboard"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}
module "iks_addon_monitor" {

  source            = "../modules/addon_policy"
  addon_policy_name = "monitor"
  addons            = "ccp-monitor"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}

module "wakanda_vcenter_policy" {
  source           = "../modules/infra_config_policy"
  name             = "wakanda_vc"
  device_name      = "wakanda-vcenter.rich.ciscolabs.com"
  vc_portgroup     = ["panther|iks|tme"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password
  org_name         = var.organization
  tags             = var.tags
}


module "ip_pool_1-139-120-0" {
  source           = "../modules/ip_pool"
  name             = "10-139-120-0"
  starting_address = "10.139.120.100"
  pool_size        = "140"
  netmask          = "255.255.255.0"
  gateway          = "10.139.120.1"
  primary_dns      = "10.101.128.15"
  secondary_dns    = "10.101.128.16"

  org_name = var.organization
  tags     = var.tags
}

module "wakanda_network" {
  source      = "../modules/k8s_network"
  policy_name = "wakanda_network"
  dns_servers = ["10.101.128.15", "10.101.128.16"]
  ntp_servers = ["10.101.128.15", "10.101.128.16"]
  domain_name = "rich.ciscolabs.com"
  timezone    = "America/New_York"
  org_name    = var.organization
  tags        = var.tags
}

module "trusted_registry" {
  source              = "../modules/trusted_registry"
  policy_name         = "wakanda_registry"
  unsigned_registries = ["10.139.10.100"]

  org_name = var.organization
  tags     = var.tags
}

module "k8s_version_1-19-5" {
  source           = "../modules/version"
  k8s_version      = "1.19.5"
  k8s_version_name = "1.19.5"

  org_name = var.organization
  tags     = var.tags
}

module "k8s_worker_small" {
  source    = "../modules/worker_profile"
  name      = "k8s_small_2"
  cpu       = 4
  memory    = 163843
  disk_size = 40

  org_name = var.organization
  tags     = var.tags
}


module "iks_cluster" {
  source = "../modules/cluster"
  name   = "iks_demo"
  # action = "Deploy"
  ip_pool_moid    = module.ip_pool_1-139-120-0.ip_pool_moid
  load_balancer   = 1
  ssh_key         = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBl8AgXK9Ypm5prmzRnuhDs9WqExSDOsoduwQYVF6jSqheKnDv4ThPXTp2xWkVIhRFwOjFXuHYOF7E35cOy/c34= jusbarks@JUSBARKS-M-D2JU"
  ssh_user        = "iksadmin"
  net_config_moid = module.wakanda_network.network_policy_moid
  sys_config_moid = module.wakanda_network.sys_config_policy_moid

  org_name = var.organization
  tags     = var.tags
}

module "iks_control_profile" {
  source       = "../modules/node_profile"
  name         = "control_iks_demo"
  profile_type = "ControlPlane"
  desired_size = 1
  max_size     = 3
  ip_pool_moid = module.ip_pool_1-139-120-0.ip_pool_moid
  version_moid = module.k8s_version_1-19-5.version_policy_moid
  cluster_moid = module.iks_cluster.cluster_moid
  org_name     = var.organization
  tags         = var.tags
}

module "iks_worker_profile" {
  source       = "../modules/node_profile"
  name         = "worker_iks_demo"
  profile_type = "Worker"
  desired_size = 1
  max_size     = 50
  ip_pool_moid = module.ip_pool_1-139-120-0.ip_pool_moid
  version_moid = module.k8s_version_1-19-5.version_policy_moid
  cluster_moid = module.iks_cluster.cluster_moid
  org_name     = var.organization
  tags         = var.tags
}
module "prod_vcenter_control_provider" {
  source                   = "../modules/infra_provider"
  name                     = "iks_control"
  instance_type_moid       = module.k8s_worker_small.worker_profile_moid
  node_group_moid          = module.iks_control_profile.node_group_profile_moid
  infra_config_policy_moid = module.wakanda_vcenter_policy.infra_config_moid
  org_name                 = var.organization
  tags                     = var.tags
}
module "prod_vcenter_worker_provider" {
  source                   = "../modules/infra_provider"
  name                     = "iks_worker"
  instance_type_moid       = module.k8s_worker_small.worker_profile_moid
  node_group_moid          = module.iks_worker_profile.node_group_profile_moid
  infra_config_policy_moid = module.wakanda_vcenter_policy.infra_config_moid
  org_name                 = var.organization
  tags                     = var.tags
}