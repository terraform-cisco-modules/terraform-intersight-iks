# addons - Intersight IKS Infrastructure Provider Terraform Module

## Usage

```hcl
module "iks_infra_provider" {

  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"

  # omitted...
}
```

This module will lookup the infrastructure target (i.e. vCenter) via the target name.  It will then create a Kubernetes Infrastructure Provider using that target and the additional variables defined in infra_list.


These resources are created
* [infrastructure provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infrastructure_provider)



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
| description | Description to be used to describe the infrastructure provider policy | `string` | `""` | no |
| infra\_config\_policy\_moid | MOID of the Infra Config Policy mapped to this provider | `string` | `""` | no |
| instance\_type\_moid | MOID of the Instance type mapped to this provider | `string` | `""` | no |
| name | Name of the Infrastructure Provider to be created | `string` | n/a | yes |
| node\_group\_moid | MOID of the Node Group mapped to this provider | `string` | `""` | no |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| infra\_provider\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->