provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iwe" {
  # source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  source = "../../modules/infra_config_policy"
  # version = "2.0.4"
  vmConfig = {
    platformType = "iwe"
    targetName   = "falcon"
    policyName   = "iwe-test"
    description  = "Test Policy"
    interfaces   = ["iwe-guests"]
  }

  org_name = var.organization
  tags     = var.tags
}

module "vcenter" {
  source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  version = "2.0.4"
  vmConfig = {
    platformType       = "esxi"
    targetName         = "marvel-vcsa.rich.ciscolabs.com"
    policyName         = "esxi-test"
    description        = "Test Policy"
    interfaces         = ["iwe-guests"]
    vcClusterName      = "test"
    vcDatastoreName    = "test"
    vcPassword         = "12345"
    vcResourcePoolName = ""
  }

  org_name = var.organization
  tags     = var.tags
}


