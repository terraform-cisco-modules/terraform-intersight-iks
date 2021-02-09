provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "k8s_version_1-18-12" {
  source           = "terraform-cisco-modules/iks/intersight//modules/modules/version"
  k8s_version      = "1.18.12"
  k8s_version_name = "test_1.18.12"

  org_name = var.organization
  tags     = var.tags
}