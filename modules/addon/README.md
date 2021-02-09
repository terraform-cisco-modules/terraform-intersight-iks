# addons - Intersight IKS Addon Terraform Module

## Usage

```hcl
module "iks_addon" {

  source = "terraform-cisco-modules/iks/intersight//modules/modules/addon"

  # omitted...
}
```

This module will create addons that can be consumed by the addon_policy.  See the examples for complete usage.

#### Current Available Addons
* kubernetes-dashboard
* ccp-monitor

These resources are created
* [addon](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_addon)


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
| addon\_name | Name of addon to be installed on a Kubernetes cluster.  Current available addons are kubernetes-dashboard and ccp-monitor. | `string` | n/a | yes |
| install\_strategy | Addon install strategy to determine whether an addon is installed if not present.\* InstallOnly - Only install in green field. No action in case of failure or removal.\* NoAction - No install action performed.\* Always - Attempt install if chart is not already installed. | `string` | `""` | no |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| upgrade\_strategy | Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.\* UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.\* NoAction - This choice enables No upgrades to be performed.\* ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.\* AlwaysReinstall - Always remove older release and reinstall. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->