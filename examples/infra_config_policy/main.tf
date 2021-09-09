provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_vcenter" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  name             = "marvel_vc"
  device_name      = "marvel-vcsa.rich.ciscolabs.com"
  vc_portgroup     = ["panther|iks|tme"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password
  org_name         = var.organization
  tags             = var.tags
}


