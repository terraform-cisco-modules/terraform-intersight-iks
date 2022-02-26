# Create Addons

This example creates addons and based on the information provided in the module.

## Usage

To run this create a 'main.tf', 'variables.tf' and 'versions.tf' file and place them in the same folder.  Modify the attributes below to meet your needs and run 

```bash
terraform init
terraform plan
terraform apply
```

The list of supported addons is continuously growing.  Please check the documentation for the most current information.

** Additional ".tf" file examples are located within the GITHUB Repo.  Link Above.

```hcl
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}


module "smm" {
  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon = {
    policyName = "smm-tf"
    addonName            = "smm"
    description       = "SMM Policy"
    upgradeStrategy  = "AlwaysReinstall"
    installStrategy  = "InstallOnly"
    releaseVersion = "1.7.4-cisco4-helm3"
    overrides = yamlencode({"demoApplication":{"enabled":true}
    })
  }

  org_name = var.organization
  tags     = var.tags
}

module "monitor" {
  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addon = {
    policyName = "monitor-tf"
    addonName            = "ccp-monitor"
    description       = "Monitor Policy"
    upgradeStrategy  = "AlwaysReinstall"
    installStrategy  = "InstallOnly"
    releaseVersion = "0.2.61-helm3"
    overrides = yamlencode({"demoApplication":{"enabled":true}
    })
  }

  org_name = var.organization
  tags     = var.tags
}
```



Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | =1.0.18 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitor"></a> [monitor](#module\_monitor) | terraform-cisco-modules/iks/intersight//modules/addon_policy | n/a |
| <a name="module_smm"></a> [smm](#module\_smm) | terraform-cisco-modules/iks/intersight//modules/addon_policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | API Key | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Secret Key or file location | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->