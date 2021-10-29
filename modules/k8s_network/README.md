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
| [intersight_kubernetes_network_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy) | resource |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cni"></a> [cni](#input\_cni) | Supported CNI type. Currently we only support Calico.* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | Pod CIDR Block to be used to assign POD IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | Service CIDR Block used to assign cluster service IP addresses. | `string` | `"100.64.0.0/24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_policy_moid"></a> [network\_policy\_moid](#output\_network\_policy\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->