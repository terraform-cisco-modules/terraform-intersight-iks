provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_addon_dashboard" {
  source           = "../../modules/addon"
  addon_name       = "kubernetes-dashboard"
  upgrade_strategy = "UpgradeOnly"
  org_name         = var.organization
  tags             = var.tags
}

module "iks_addon_monitor" {
  source           = "../../modules/addon"
  addon_name       = "ccp-monitor"
  upgrade_strategy = "UpgradeOnly"
  org_name         = var.organization
  tags             = var.tags
}
module "iks_addon_policy_default" {
  source            = "../../modules/addon_policy"
  addon_policy_name = "default"
  addons            = ["ccp-monitor", "kubernetes-dashboard"]
  org_name          = var.organization
  tags              = var.tags
}
# module "iks_worker_instance_type" {

#   source        = "../../modules/worker_profile"
#   instance_type = var.instance_type
#   org_name      = var.organization
#   tags          = var.tags
# }
# module "iks_network_policies" {

#   source   = "../../modules/network"
#   org_name = var.organization
#   # Kubernetes Network Policy
#   network_policy_list = var.network_policy_list
#   tags                = var.tags

# }
# module "network_ip_pool" {
#   source       = "../../network"
#   ip_pool_list = var.ip_pool_list
#   org_name     = var.organization
#   tags         = var.tags
# }

# module "iks_version" {
#   source = "../../modules/version"

#   org_name         = var.organization
#   k8s_version_list = var.k8s_version_list
#   tags             = var.tags
# }
# module "iks_addon" {
#   source            = "../../modules/addon"
#   org_name          = var.organization
#   addon_list        = var.addon_list
#   addon_policy_name = var.addon_policy_name
#   tags              = var.tags
# }
# module "iks_infra_provider" {
#   source     = "../../modules/infra"
#   org_name   = var.organization
#   infra_list = var.infra_list
#   tags       = var.tags

# }