provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "cluster_addon_profile" {

  source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  profile_name = "test-addon"
  addons       = ["dashboard"]

  org_name = var.organization
  tags     = var.tags
}
