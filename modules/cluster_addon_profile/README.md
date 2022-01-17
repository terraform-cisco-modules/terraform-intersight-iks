# Cluster Addon Profile

This module creates an addon profile to be used by clusters.  It uses one or more addons and is assigned to an IKS cluster

## Usage

```hcl
module "iks_cluster_profile" {

  source = "terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile"

  # omitted...
}
```

These resources are created

* [cluster_addon_profile](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_addon_profile)


Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
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
| [intersight_kubernetes_cluster_addon_profile.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_addon_profile) | resource |
| [intersight_kubernetes_addon_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_addon_policy) | data source |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons"></a> [addons](#input\_addons) | n/a | <pre>list(object({<br>    addonPolicyName  = string<br>    addonName        = string<br>    description      = optional(string)<br>    upgradeStrategy  = optional(string)<br>    installStrategy  = optional(string)<br>    overrideSets     = optional(list(map(string)))<br>    overrides        = optional(string)<br>    releaseName      = optional(string)<br>    releaseNamespace = optional(string)<br>    releaseVersion   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_cluster_moid"></a> [cluster\_moid](#input\_cluster\_moid) | MOID of the cluster to be associated with this cluster addon profile. | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | Name of the Cluster Addon Policy | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addon_profile"></a> [addon\_profile](#output\_addon\_profile) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->