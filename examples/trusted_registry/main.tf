provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  policy_name         = "test"
  unsigned_registries = ["10.139.10.100"]

  org_name = var.organization
  tags     = var.tags
}