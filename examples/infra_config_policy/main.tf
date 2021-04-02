provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_vcenter" {
  source           = "../../modules/infra_config_policy"
  name             = "wakanda_vc"
  device_name      = "wakanda-vcenter.rich.ciscolabs.com"
  vc_portgroup     = ["panther|iks|tme"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password
  org_name         = var.organization
  tags             = var.tags
}


