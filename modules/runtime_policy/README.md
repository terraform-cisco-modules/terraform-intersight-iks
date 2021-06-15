# addons - Intersight IKS Container Runtime Policy Terraform Module

## Usage

```hcl
module "iks_runtime_policy" {

  source = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"

  # omitted...
}
```

This module will create a container runtime policy policy for IKS.  These policies can then be used to create IKS clusters.  This is an optional policy for IKS.  The container runtime policy provides for things such as proxy information and custom docker bridge CIDR information.


These resources are created:

* [runtime-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_container_runtime_policy)

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
| description | Description to be used to describe the addon policy | `string` | `""` | no |
| docker\_bridge\_cidr | Docker Bridge CIDR network to be specified. | `string` | `""` | no |
| docker\_no\_proxy | Networks excluded from the proxy. | `list(string)` | `[]` | no |
| name | Name of the Container Runtime Policy to be created. | `string` | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| proxy\_http\_hostname | HTTP Proxy server FQDN or IP. | `string` | n/a | yes |
| proxy\_http\_password | The password for the HTTP Proxy. | `string` | `""` | no |
| proxy\_http\_port | The HTTP Proxy port number.The port number of the HTTP proxy must be between 1 and 65535, inclusive. | `number` | `8080` | no |
| proxy\_http\_protocol | Protocol to use for the HTTPS Proxy. | `string` | `"http"` | no |
| proxy\_http\_username | The username for the HTTP Proxy. | `string` | `""` | no |
| proxy\_https\_hostname | HTTPS Proxy server FQDN or IP. | `string` | n/a | yes |
| proxy\_https\_password | The password for the HTTPS Proxy. | `string` | `""` | no |
| proxy\_https\_port | The HTTPS Proxy port number.The port number of the HTTPS proxy must be between 1 and 65535, inclusive. | `number` | `8443` | no |
| proxy\_https\_protocol | Protocol to use for the HTTPS Proxy. | `string` | `"https"` | no |
| proxy\_https\_username | The username for the HTTPS Proxy. | `string` | `""` | no |
| tags | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| runtime\_policy\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->