# worker_profile - Intersight IKS Worker Profile Policy Terraform Module

## Usage

```hcl
module "iks_worker_profile" {

  source = "terraform-cisco-modules/iks/intersight//modules/worker_profile"

  # omitted...
}
```

This module will create a VM Instance Policy for IKS.  This policy can then be used to create IKS clusters.  This can be used to create "t-shirt" sizes for the worker nodes.  (i.e small, medium, large, x-large, etc...)


These resources are created
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.5 |
| intersight | >=1.0.7 |

## Providers

| Name | Version |
|------|---------|
| intersight | >=1.0.7 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cpu | Number of CPU allocated to the virtual machine. | `number` | `4` | no |
| disk\_size | Amount of disk to be assigned to the virtual machine in GiB. | `number` | `40` | no |
| memory | Amount of memory assigned to the virtual machine in MiB. | `number` | `16384` | no |
| name | Name of the Worker Profile to be created.  i.e small | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| worker\_profile\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->