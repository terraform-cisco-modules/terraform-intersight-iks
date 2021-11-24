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
| [intersight_kubernetes_container_runtime_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_container_runtime_policy) | resource |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the addon policy | `string` | `""` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | Docker Bridge CIDR network to be specified. | `string` | `""` | no |
| <a name="input_docker_no_proxy"></a> [docker\_no\_proxy](#input\_docker\_no\_proxy) | Networks excluded from the proxy. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Container Runtime Policy to be created. | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_proxy_http_hostname"></a> [proxy\_http\_hostname](#input\_proxy\_http\_hostname) | HTTP Proxy server FQDN or IP. | `string` | n/a | yes |
| <a name="input_proxy_http_password"></a> [proxy\_http\_password](#input\_proxy\_http\_password) | The password for the HTTP Proxy. | `string` | `""` | no |
| <a name="input_proxy_http_port"></a> [proxy\_http\_port](#input\_proxy\_http\_port) | The HTTP Proxy port number.The port number of the HTTP proxy must be between 1 and 65535, inclusive. | `number` | `8080` | no |
| <a name="input_proxy_http_protocol"></a> [proxy\_http\_protocol](#input\_proxy\_http\_protocol) | Protocol to use for the HTTPS Proxy. | `string` | `"http"` | no |
| <a name="input_proxy_http_username"></a> [proxy\_http\_username](#input\_proxy\_http\_username) | The username for the HTTP Proxy. | `string` | `""` | no |
| <a name="input_proxy_https_hostname"></a> [proxy\_https\_hostname](#input\_proxy\_https\_hostname) | HTTPS Proxy server FQDN or IP. | `string` | n/a | yes |
| <a name="input_proxy_https_password"></a> [proxy\_https\_password](#input\_proxy\_https\_password) | The password for the HTTPS Proxy. | `string` | `""` | no |
| <a name="input_proxy_https_port"></a> [proxy\_https\_port](#input\_proxy\_https\_port) | The HTTPS Proxy port number.The port number of the HTTPS proxy must be between 1 and 65535, inclusive. | `number` | `8443` | no |
| <a name="input_proxy_https_protocol"></a> [proxy\_https\_protocol](#input\_proxy\_https\_protocol) | Protocol to use for the HTTPS Proxy. | `string` | `"https"` | no |
| <a name="input_proxy_https_username"></a> [proxy\_https\_username](#input\_proxy\_https\_username) | The username for the HTTPS Proxy. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_runtime_policy_moid"></a> [runtime\_policy\_moid](#output\_runtime\_policy\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->