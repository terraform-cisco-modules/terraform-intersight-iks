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
| intersight | =1.0.0 |

## Providers

| Name | Version |
|------|---------|
| intersight | =1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| action | Ation for cluster. i.e 'Deploy' 'Unassign' | `string` | `""` | no |
| addon\_policy\_moid | MOID derived from the Addon Policy that is being consumed. | `string` | n/a | yes |
| ip\_pool\_moid | MOID derived from the IP Pool that is being consumed. | `string` | n/a | yes |
| load\_balancer | Number of load balancer addresses to deploy. | `number` | n/a | yes |
| name | Name of the IKS Cluster to be deployed. | `string` | n/a | yes |
| net\_config\_moid | MOID derived from the Network Config Policy that is being consumed. | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| ssh\_key | SSH Public Key to be used to node login. | `string` | n/a | yes |
| ssh\_user | SSH Username for node login. | `string` | n/a | yes |
| sys\_config\_moid | MOID derived from the System Config Policy that is being consumed. | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| trusted\_registry\_policy\_moid | MOID derived from the Trusted Registry Policy that is being consumed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->