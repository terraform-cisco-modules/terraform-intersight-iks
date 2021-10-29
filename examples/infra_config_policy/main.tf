provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_vcenter" {
  source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  version = "2.0.4"
  vmConfig = {
    platformType = "iwe"
    targetName   = "falcon"
    policyName   = "falcon-prod"
    description  = "Test Policy"
    interfaces   = ["iwe-guests"]
    # vcTargetName   = optional(string)
    # vcClusterName      = optional(string)
    # vcDatastoreName     = optional(string)
    # vcResourcePoolName = optional(string)
    # vcPassword      = optional(string)
  }

  org_name = var.organization
  tags     = var.tags
}


