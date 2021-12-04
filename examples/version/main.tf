provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "k8s_version_1-19-5" {
  source         = "terraform-cisco-modules/iks/intersight//modules/version"
  policyName     = "1.19.5"
  iksVersionName = "1.19.5-iks-0"

  org_name = var.organization
  tags     = var.tags
}

module "k8s_version_1-19-15-iks3" {
  source         = "terraform-cisco-modules/iks/intersight//modules/version"
  policyName     = "1-19-15-iks.3"
  iksVersionName = "1.19.15-iks.3"

  org_name = var.organization
  tags     = var.tags
}