provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "cluster_addon_profile" {

  source       = "../../modules/cluster_addon_profile"
  profile_name = "test-addon"
  addons       = ["dashboard"]
  cluster_moid = "606f3a7f7a6f722d3071eccc"

  org_name = var.organization
  tags     = var.tags
}

# data "intersight_kubernetes_cluster_addon_profile" "profile" {
#   # name = "dashboard-test"
# }