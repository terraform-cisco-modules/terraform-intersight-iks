# addons - Intersight IKS Infrastructure Provider Terraform Module

## Usage

```hcl
module "iks_infra_provider" {

  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"

  # omitted...
}
```

This module will lookup the infrastructure target (i.e. vCenter) via the target name.  It will then create a Kubernetes Infrastructure Configuration Policy for that target.  This can be used to build IKS clusters.  

The variable "device_name" is the target name for the infrastructure provider.  This can be located in Intersight--->Targets


These resources are created
* [infrastructure provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | >=1.0.7 |

## Providers

| Name | Version |
|------|---------|
| intersight | >=1.0.7 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Description to be used to describe the infrastructure configuration policy | `string` | `""` | no |
| device\_name | Name of the Virtual Machine Provider you wish to add.  i.e vCenter | `string` | n/a | yes |
| name | Name of the Infrastructure Provider to be created | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | `"default"` | no |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| vc\_cluster | Name of the cluster you wish to make part of this provider within vCenter. | `string` | n/a | yes |
| vc\_datastore | Name of the datastore to be used with this provider. | `string` | n/a | yes |
| vc\_password | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |
| vc\_portgroup | Name of the portgroup(s) to be used in this provider | `list(string)` | n/a | yes |
| vc\_resource\_pool | Name of the resource pool to be used with this provider. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| infra\_config\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->