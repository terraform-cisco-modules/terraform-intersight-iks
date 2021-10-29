provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "ip_pool_1-139-140-0" {
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  version          = "2.0.4"
  name             = "test_139"
  starting_address = "10.139.140.200"
  pool_size        = "20"
  netmask          = "255.255.255.0"
  gateway          = "10.139.140.1"
  primary_dns      = "10.101.128.15"
  secondary_dns    = "10.101.128.16"

  org_name = var.organization
  tags     = var.tags
}