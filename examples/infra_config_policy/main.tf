provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

#Policy Example for IWE
module "iwe" {
  source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  version = "2.0.4"
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
#Policy Example for Vcenter
module "vcenter" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
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


