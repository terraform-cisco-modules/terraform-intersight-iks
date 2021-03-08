provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_vcenter" {
  source             = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name               = "wakanda_vc"
  device_name        = "wakanda-vcenter.rich.ciscolabs.com"
  vc_portgroup       = ["panther|ccp|control"]
  vc_datastore       = "iks"
  vc_cluster         = "tchalla"
  vc_resource_pool   = ""
  instance_type_moid = module.k8s_worker_small.worker_profile_moid
  vc_password        = var.vc_password
  org_name           = var.organization
  tags               = var.tags
}

