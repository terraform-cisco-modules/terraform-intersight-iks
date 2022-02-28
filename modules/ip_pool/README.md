# ip_pool - Intersight IP Pool Terraform Module

## Usage

```hcl
module "ip_pool" {

  source = "terraform-cisco-modules/iks/intersight//modules/ip_pool"

  # omitted...
}
```

This module will deploy an IP Pool Policy within Intersight.  This can be used to create IKS clusters or other objects that require an IP Pool.  


These resources are created

* [ippool](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ippool_pool)

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
| [intersight_ippool_pool.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ippool_pool) | resource |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the IP Pool Policy. | `string` | `""` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | Default gateway for this pool. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the IP Pool to be created. | `string` | n/a | yes |
| <a name="input_netmask"></a> [netmask](#input\_netmask) | Subnet Mask for this pool. | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_pool_size"></a> [pool\_size](#input\_pool\_size) | Number of IPs you want this pool to contain. | `string` | n/a | yes |
| <a name="input_primary_dns"></a> [primary\_dns](#input\_primary\_dns) | Primary DNS Server for this pool. | `string` | n/a | yes |
| <a name="input_secondary_dns"></a> [secondary\_dns](#input\_secondary\_dns) | Secondary DNS Server for this pool. | `string` | `""` | no |
| <a name="input_starting_address"></a> [starting\_address](#input\_starting\_address) | Starting IP Address you want for this pool. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_pool_moid"></a> [ip\_pool\_moid](#output\_ip\_pool\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->