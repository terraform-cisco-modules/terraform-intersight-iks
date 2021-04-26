# addons - Intersight IKS Network Policy Terraform Module

## Usage

```hcl
module "iks_network_policies" {

  source = "terraform-cisco-modules/iks/intersight//modules/k8s_network"

  # omitted...
}
```

This module will create the Network and System Configuration policies for IKS.  These policies can then be used to create IKS clusters.

Currently the DNS and NTP servers requires two values, a primary and a secondary.  If you ONLY have a single DNS or NTP server, add the primary server twice.

*This is a todo to fix.


These resources are created
* [Network Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy)
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)




<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | >=1.0.7 |

## Providers

| Name | Version |
|------|---------|
| intersight | >=1.0.7 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cni | Supported CNI type. Currently we only support Calico.\* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| dns\_servers | DNS Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| domain\_name | Domain Name information for DNS search. | `string` | n/a | yes |
| ntp\_servers | NTP Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| pod\_cidr | Pod CIDR Block to be used to assign POD IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| policy\_name | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| service\_cidr | Service CIDR Block used to assign cluster service IP addresses. | `string` | `"100.64.0.0/24"` | no |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| timezone | The timezone of the node's system clock. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_policy\_moid | n/a |
| sys\_config\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->