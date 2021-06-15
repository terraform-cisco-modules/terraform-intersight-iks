# Worker Profile

This example creates a worker profile based on the information provided in the module.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
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
| addons | List of addons to be added to the policy. | `list(string)` | `[]` | no |
| cluster\_moid | MOID of the cluster to be associated with this cluster addon profile. | `string` | `""` | no |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| profile\_name | Name of the Cluster Addon Policy | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| addon\_profile | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->