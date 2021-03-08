# worker_profile - Intersight IKS Worker Profile Policy Terraform Module

## Usage

```hcl
module "iks_worker_profile" {

  source = "../../modules/worker_profile"

  # omitted...
}
```

This module will create a VM Instance Policy for IKS.  This policy can then be used to create IKS clusters.


These resources are created
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.5 |
| intersight | =1.0.2 |

## Providers

| Name | Version |
|------|---------|
| intersight | =1.0.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_moid | MOID derived from the Cluster that is being consumed. | `string` | n/a | yes |
| description | Descripton of the Node Profile. | `string` | `""` | no |
| desired\_size | Desired size for node profile.  For master profiles values an be 1 or 3 | `number` | `1` | no |
| infra\_moid | MOID derived from the Infrastructure Provider that is being consumed. | `string` | n/a | yes |
| ip\_pool\_moid | MOID derived from the IP Pool that is being consumed. | `string` | n/a | yes |
| name | Name of the Node Profile to be created. | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| profile\_type | Type of profile to be created. i.e Master or Worker | `string` | `""` | no |
| tags | n/a | `list(map(string))` | `[]` | no |
| version\_moid | MOID derived from the Version Policy that is being consumed. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->