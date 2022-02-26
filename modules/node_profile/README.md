# worker_profile - Intersight IKS Worker Profile Policy Terraform Module

## Usage

```hcl
module "iks_worker_profile" {

  source = "terraform-cisco-modules/iks/intersight//modules/worker_profile"

  # omitted...
}
```

This module will create a Node Profiles for building IKS clusters.
This can be used to create custom IKS cluster modules.  It is used in the complete IKS cluster module define the worker pool desired size.



These resources are created
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)



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
| [intersight_kubernetes_node_group_profile.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_node_group_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | User Initiated action.  Options are {{Delete\|Deploy\|Ready\|No-op\|Unassign}. | `string` | `"No-op"` | no |
| <a name="input_cluster_moid"></a> [cluster\_moid](#input\_cluster\_moid) | MOID derived from the Cluster that is being consumed. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Descripton of the Node Profile. | `string` | `""` | no |
| <a name="input_ip_pool_moid"></a> [ip\_pool\_moid](#input\_ip\_pool\_moid) | MOID derived from the IP Pool that is being consumed. | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum size for node profile. | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum size for node profile. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Node Profile to be created. | `string` | n/a | yes |
| <a name="input_profile_type"></a> [profile\_type](#input\_profile\_type) | Type of profile to be created. i.e Master or Worker | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_version_moid"></a> [version\_moid](#input\_version\_moid) | MOID derived from the Version Policy that is being consumed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_node_group_profile_moid"></a> [node\_group\_profile\_moid](#output\_node\_group\_profile\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->