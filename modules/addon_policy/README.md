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
| terraform | >=0.14.5 |
| intersight | =1.0.4 |

## Providers

| Name | Version |
|------|---------|
| intersight | =1.0.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addon\_policy\_name | Name of the Addon Policy to be created. | `string` | n/a | yes |
| addons | Addon to be added to the policy.  See Terraform documentation for list of supported addons. | `string` | `""` | no |
| description | Description to be used to describe the addon policy | `string` | `""` | no |
| install\_strategy | Addon install strategy to determine whether an addon is installed if not present.\* InstallOnly - Only install in green field. No action in case of failure or removal.\* NoAction - No install action performed.\* Always - Attempt install if chart is not already installed. | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| upgrade\_strategy | Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.\* UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.\* NoAction - This choice enables No upgrades to be performed.\* ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.\* AlwaysReinstall - Always remove older release and reinstall. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| addon\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->