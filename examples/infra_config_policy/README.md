# Infrastructure Provider for IKS

This example creates an Infrastructure Provider policy based on the information provided in the module.

## Usage

To run this create a 'main.tf', 'variables.tf' and 'versions.tf' file and place them in the same folder.  Modify the attributes below to meet your needs and run 

```bash
terraform init
terraform plan
terraform apply
```


```hcl
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
  source  = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
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
| <a name="module_iwe"></a> [iwe](#module\_iwe) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | 2.0.4 |
| <a name="module_vcenter"></a> [vcenter](#module\_vcenter) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | n/a |

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
| <a name="input_vc_password"></a> [vc\_password](#input\_vc\_password) | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->