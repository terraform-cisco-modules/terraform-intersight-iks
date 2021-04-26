# addons - Intersight IKS Trusted Registries Policy Terraform Module

## Usage

```hcl
module "iks_registry_policies" {

  source = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"

  # omitted...
}
```

This module will create a trusted registries policy for IKS.  These policies can then be used to create IKS clusters.  This is an optional policy for IKS.


These resources are created
* [Trusted Registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_trusted_registries_policy)




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
| org\_name | Intersight Organization name | `string` | n/a | yes |
| policy\_name | Name of the policy.  `_Network` and `_pod` will be added to the end of the name for the respective policies to be built. | `string` | n/a | yes |
| root\_ca\_registries | List of root CA certificates. | `list(string)` | `[]` | no |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| unsigned\_registries | List of unsigned registries to be supported. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| trusted\_registry\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->