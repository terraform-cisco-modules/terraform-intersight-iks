# addons - Intersight IKS Network Policy Terraform Module

## Usage

```hcl
module "iks_network_policies" {

  source = "terraform-cisco-modules/iks/intersight//modules/k8s_network"

  # omitted...
}
```

This module will create the Network Configuration policiy for IKS.  This policy can then be used to create IKS clusters.



These resources are created
* [Network Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy)




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
| cni | Supported CNI type. Currently we only support Calico.\* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| pod\_cidr | Pod CIDR Block to be used to assign POD IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| policy\_name | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| service\_cidr | Service CIDR Block used to assign cluster service IP addresses. | `string` | `"100.64.0.0/24"` | no |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| network\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->