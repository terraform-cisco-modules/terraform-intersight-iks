# addons - Intersight IKS Infrastructure Provider Terraform Module

## Usage

```hcl
module "iks_infra_provider" {

  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"

  # omitted...
}
```

This module will lookup the infrastructure target (i.e. vCenter) via the target name.  It will then create a Kubernetes Infrastructure Configuration Policy for that target.  This can be used to build IKS clusters.  

The variable "device_name" is the target name for the infrastructure provider.  This can be located in Intersight--->Targets
For the Platform Type options are "esxi" or "iwe".




These resources are created
* [infrastructure config](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.18 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_kubernetes_virtual_machine_infra_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy) | resource |
| [intersight_asset_target.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/asset_target) | data source |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | `"default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_vmConfig"></a> [vmConfig](#input\_vmConfig) | n/a | <pre>object({<br>    platformType       = string<br>    targetName         = string<br>    policyName         = string<br>    description        = optional(string)<br>    interfaces         = list(string)<br>    diskMode           = optional(string)<br>    vcClusterName      = optional(string)<br>    vcDatastoreName    = optional(string)<br>    vcResourcePoolName = optional(string)<br>    vcPassword         = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_infra_config_moid"></a> [infra\_config\_moid](#output\_infra\_config\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->