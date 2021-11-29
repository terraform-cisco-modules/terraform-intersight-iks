# addons - Intersight IKS Network Policy Terraform Module

## Usage

```hcl
module "iks_network_policies" {

  source = "terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig"

  # omitted...
}
```

This module will create the System Configuration policy for IKS.  This policy can then be used to create IKS clusters.  In the Intersight UI this is referenced as Type 'Network CIDR'


These resources are created
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)




<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
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
| [intersight_kubernetes_sys_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy) | resource |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the K8s sysconfig profile. | `string` | `""` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | DNS Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name information for DNS search. | `string` | n/a | yes |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | NTP Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The timezone of the node's system clock. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sys_config_policy_moid"></a> [sys\_config\_policy\_moid](#output\_sys\_config\_policy\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->