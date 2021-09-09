# addons - Intersight IKS Network Policy Terraform Module

## Usage

```hcl
module "iks_network_policies" {

  source = "terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig"

  # omitted...
}
```

This module will create the System Configuration policy for IKS.  This policy can then be used to create IKS clusters.


These resources are created
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)




<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | >=1.0.11 |

## Providers

| Name | Version |
|------|---------|
| intersight | >=1.0.11 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_servers | DNS Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| domain\_name | Domain Name information for DNS search. | `string` | n/a | yes |
| ntp\_servers | NTP Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| policy\_name | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| timezone | The timezone of the node's system clock. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sys\_config\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->