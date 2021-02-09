provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "ip_pool_1-139-140-0" {
  source           = "../../ip_pool"
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