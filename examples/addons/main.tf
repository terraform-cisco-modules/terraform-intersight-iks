provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "iks_addon_dashboard" {

  source            = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon_policy_name = "dashboard"
  addons            = "kubernetes-dashboard"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}
module "iks_addon_monitor" {

  source            = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon_policy_name = "monitor"
  addons            = "ccp-monitor"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}