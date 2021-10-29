# addons - Intersight IKS Infrastructure Provider Terraform Module

## Usage

```hcl
module "iks_infra_provider" {

  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"

  # omitted...
}
```

This module creates the infrastructure provider for deploying IKS clusters.  It is not meant to be used standalone, but it can be used for custom IKS cluster modules.

There are 3 values that are looked up. 
instance_type_moid
node_group_moid
infra_config_policy_moid

These values are derived from other module builds or manual object builds within Intersight.


These resources are created
* [infrastructure provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infrastructure_provider)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.17 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.17 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_kubernetes_virtual_machine_infrastructure_provider.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infrastructure_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the infrastructure provider policy | `string` | `""` | no |
| <a name="input_infra_config_policy_moid"></a> [infra\_config\_policy\_moid](#input\_infra\_config\_policy\_moid) | MOID of the Infra Config Policy mapped to this provider | `string` | `""` | no |
| <a name="input_instance_type_moid"></a> [instance\_type\_moid](#input\_instance\_type\_moid) | MOID of the Instance type mapped to this provider | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Infrastructure Provider to be created | `string` | n/a | yes |
| <a name="input_node_group_moid"></a> [node\_group\_moid](#input\_node\_group\_moid) | MOID of the Node Group mapped to this provider | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_infra_provider_moid"></a> [infra\_provider\_moid](#output\_infra\_provider\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->