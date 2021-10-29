provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}


module "prod_vcenter" {
  source                   = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  version                  = "2.0.4"
  name                     = "wakanda_vc_worker_3"
  instance_type_moid       = ""
  node_group_moid          = ""
  infra_config_policy_moid = ""
  tags                     = var.tags
}




