# addons - Intersight IKS Addon Terraform Module

## Usage

```hcl
module "iks_addon_policy" {

  source = "terraform-cisco-modules/iks/intersight//modules/addon_policy"

  # omitted...
}
```

This module will loop through all addons in `addons` and add them to the addon policy.  This policy can be used when deploying IKS clusters.


These resources are created

* [addon-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_addon_policy)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | =0.14.5 |
| intersight | =1.0.0 |

## Providers

| Name | Version |
|------|---------|
| intersight | =1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addon\_policy\_name | Name of the Addon Policy to be created. | `string` | n/a | yes |
| addons | List of addons to be added to the policy. | `list(string)` | `[]` | no |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->