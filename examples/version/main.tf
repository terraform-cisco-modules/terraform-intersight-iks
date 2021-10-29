provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "k8s_version_1-19-5" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  version          = "2.0.4"
  k8s_version      = "1.19.5"
  k8s_version_name = "test_1.19.5"

  org_name = var.organization
  tags     = var.tags
}