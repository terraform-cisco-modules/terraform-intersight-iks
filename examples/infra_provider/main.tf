provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}


module "prod_vcenter" {
  source                   = "../../modules/infra_provider"
  name                     = "wakanda_vc_worker_3"
  instance_type_moid       = "6062fa977a6f722d3081e949"
  node_group_moid          = "606606627a6f722d30bcd0d8"
  infra_config_policy_moid = "6062fa7e7a6f722d3081e701"
  org_name                 = var.organization
  tags                     = var.tags
}


