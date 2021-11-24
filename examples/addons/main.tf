provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}


module "smm" {
  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon = {
    policyName      = "smm-tf"
    addonName       = "smm"
    description     = "SMM Policy"
    upgradeStrategy = "AlwaysReinstall"
    installStrategy = "InstallOnly"
    releaseVersion  = "1.7.4-cisco4-helm3"
    overrides = yamlencode({ "demoApplication" : { "enabled" : true }
    })
  }

  org_name = var.organization
  tags     = var.tags
}

module "monitor" {
  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon = {
    policyName      = "monitor-tf"
    addonName       = "ccp-monitor"
    description     = "Monitor Policy"
    upgradeStrategy = "AlwaysReinstall"
    installStrategy = "InstallOnly"
    releaseVersion  = "0.2.61-helm3"
    overrides = yamlencode({ "demoApplication" : { "enabled" : true }
    })
  }

  org_name = var.organization
  tags     = var.tags
}
