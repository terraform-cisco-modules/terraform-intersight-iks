# Create Addons

This example creates addons and based on the information provided in the module.

## Usage

To run this create a 'main.tf', 'variables.tf' and 'versions.tf' file and place them in the same folder.  Modify the attributes below to meet your needs and run 

```bash
terraform init
terraform plan
terraform apply
```

This module uses the addon policy(s) that have already been created.  

```hcl
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "cluster_addon_profile" {

  source       = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"
  profile_name = "test-addon"
  addons       = [
    {
    addonName            = "smm-tf"
    description       = "SMM Policy"
    # upgradeStrategy  = "AlwaysReinstall"
    # installStrategy  = "InstallOnly"
    # releaseVersion = "1.7.4-cisco4-helm3"
    # overrides = yamlencode({"demoApplication":{"enabled":true}})
    },
    {
    addonName            = "monitor-tf"
    description       = "monitor Policy"
    # upgradeStrategy  = "AlwaysReinstall"
    # installStrategy  = "InstallOnly"
    # # releaseVersion = "1.7.4-cisco4-helm3"
    # overrides = yamlencode({"demoApplication":{"enabled":true}})
    }
  ]

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
| <a name="module_cluster_addon_profile"></a> [cluster\_addon\_profile](#module\_cluster\_addon\_profile) | terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile | n/a |

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