provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "cluster_addon_profile" {

  source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  profile_name = "test-addon"
  addons = [
    {
      addonName   = "smm-tf"
      description = "SMM Policy"
      # upgradeStrategy  = "AlwaysReinstall"
      # installStrategy  = "InstallOnly"
      # releaseVersion = "1.7.4-cisco4-helm3"
      # overrides = yamlencode({"demoApplication":{"enabled":true}})
    },
    {
      addonName   = "monitor-tf"
      description = "monitor Policy"
      # upgradeStrategy  = "AlwaysReinstall"
      # installStrategy  = "InstallOnly"
      # # releaseVersion = "1.7.4-cisco4-helm3"
      # overrides = yamlencode({"demoApplication":{"enabled":true}})
    }
  ]

  org_name = var.organization
  tags     = var.tags
}
