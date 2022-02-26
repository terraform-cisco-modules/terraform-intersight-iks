# addons - Intersight IKS Addon Terraform Module

## Usage

```hcl
module "iks_addon_policy" {

  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"

  # omitted...
}
```

This module will create an addon policy for the respective addon.  A list of supported addons can be found in the documentation.


These resources are created

* [addon-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_addon_policy)

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
| [intersight_kubernetes_addon_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_addon_policy) | resource |
| [intersight_kubernetes_addon_definition.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_addon_definition) | data source |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon"></a> [addon](#input\_addon) | n/a | <pre>object({<br>    policyName       = string<br>    addonName        = string<br>    description      = optional(string)<br>    upgradeStrategy  = optional(string)<br>    installStrategy  = optional(string)<br>    overrideSets     = optional(list(map(string)))<br>    overrides        = optional(string)<br>    releaseName      = optional(string)<br>    releaseNamespace = optional(string)<br>    releaseVersion   = string<br>  })</pre> | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addon_policy"></a> [addon\_policy](#output\_addon\_policy) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->