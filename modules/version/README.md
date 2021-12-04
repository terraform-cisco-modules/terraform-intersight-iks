# version - Intersight IKS Version Policy Terraform Module

## Usage

```hcl
module "iks_version" {

  source = "terraform-cisco-modules/iks/intersight//modules/version"

  # omitted...
}
```

This module will create the Kubernetes Version Policy IKS.  This policy can then be used to create IKS clusters.
Check with the IKS documentation for supported Kubernetes Versions

Current supported IKS versions are:

1.19.5
1.19.15


These resources are created
* [Version Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy)



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
| [intersight_kubernetes_version_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy) | resource |
| [intersight_kubernetes_version.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_version) | data source |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the k8s version profile. | `string` | `""` | no |
| <a name="input_iksVersionName"></a> [iksVersionName](#input\_iksVersionName) | Version name of IKS | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_policyName"></a> [policyName](#input\_policyName) | Name of the policy to be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_version_policy_moid"></a> [version\_policy\_moid](#output\_version\_policy\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->