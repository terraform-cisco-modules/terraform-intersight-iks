provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "cluster_addon_profile" {

  source       = "../../modules/cluster_addon_profile"
  profile_name = "test-addon"
  addons       = ["dashboard"]

  org_name = var.organization
  tags     = var.tags
}
