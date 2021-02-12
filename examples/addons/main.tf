provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_addon_dashboard" {
  source           = "terraform-cisco-modules/iks/intersight//modules/addon"
  addon_name       = "kubernetes-dashboard"
  upgrade_strategy = "UpgradeOnly"
  org_name         = var.organization
  tags             = var.tags
}

# module "iks_addon_monitor" {
#   source           = "terraform-cisco-modules/iks/intersight//modules/addon"
#   addon_name       = "ccp-monitor"
#   upgrade_strategy = "UpgradeOnly"
#   org_name         = var.organization
#   tags             = var.tags
# }
module "iks_addon_policy_default" {
  source            = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon_policy_name = "default"
  addons            = ["ccp-monitor", "kubernetes-dashboard"]
  org_name          = var.organization
  tags              = var.tags
}
