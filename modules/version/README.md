# version - Intersight IKS Version Policy Terraform Module

## Usage

```hcl
module "iks_version" {

  source = "terraform-cisco-modules/iks/intersight//modules/version"

  # omitted...
}
```

This module will create the Kubernetes Version Policy IKS.  This policy can then be used to create IKS clusters.
Check with the IKS documentation for supported Kubernetes Versions


These resources are created
* [Version Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy)



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
| k8s\_version | Version of the Kubernetes cluster | `string` | n/a | yes |
| k8s\_version\_name | Name of the policy to be created | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| version\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->