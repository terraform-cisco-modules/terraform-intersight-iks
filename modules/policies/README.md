# iks policies - Intersight IKS policies module

## Usage

```hcl
module "iks_addon_policy" {

  source = "terraform-cisco-modules/iks/intersight//modules/policies"

  # omitted...
}
```

This module uses the other IKS modules to create the common reuseable policies required for IKS clusters.  These policies can then be referenced by name in the main IKS module.  The Readme for each module can be used for additional information.

An example can be found under the modules.
https://registry.terraform.io/modules/terraform-cisco-modules/iks/intersight/latest/examples/policies
These resources can be created.  Each resource is defined by an object variable and can be created by using 
```
create = true
```
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)
* [infrastructure config](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy)
* [Version Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy)
* [ippool](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ippool_pool)
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)
* [Trusted Registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_trusted_registries_policy)
* [runtime-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_container_runtime_policy)
* [Network Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.17 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infra_config_policy"></a> [infra\_config\_policy](#module\_infra\_config\_policy) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | >=2.0.3 |
| <a name="module_instance_type"></a> [instance\_type](#module\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/worker_profile | >=2.0.3 |
| <a name="module_ip_pool_policy"></a> [ip\_pool\_policy](#module\_ip\_pool\_policy) | terraform-cisco-modules/iks/intersight//modules/ip_pool | >=2.0.3 |
| <a name="module_k8s_network"></a> [k8s\_network](#module\_k8s\_network) | terraform-cisco-modules/iks/intersight//modules/k8s_network | >=2.0.3 |
| <a name="module_k8s_sysconfig"></a> [k8s\_sysconfig](#module\_k8s\_sysconfig) | terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig | >=2.0.3 |
| <a name="module_k8s_version"></a> [k8s\_version](#module\_k8s\_version) | terraform-cisco-modules/iks/intersight//modules/version | >=2.0.3 |
| <a name="module_runtime_policy"></a> [runtime\_policy](#module\_runtime\_policy) | terraform-cisco-modules/iks/intersight//modules/runtime_policy | >=2.0.3 |
| <a name="module_trusted_registry"></a> [trusted\_registry](#module\_trusted\_registry) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | >=2.0.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_infraConfigPolicy"></a> [infraConfigPolicy](#input\_infraConfigPolicy) | n/a | <pre>object({<br>    create             = bool<br>    platformType       = string<br>    targetName         = string<br>    policyName         = string<br>    description        = optional(string)<br>    interfaces         = list(string)<br>    diskMode           = optional(string)<br>    vcTargetName       = optional(string)<br>    vcClusterName      = optional(string)<br>    vcDatastoreName    = optional(string)<br>    vcResourcePoolName = optional(string)<br>    vcPassword         = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | <pre>object({<br>    create    = bool<br>    name      = string<br>    cpu       = optional(number)<br>    memory    = optional(number)<br>    disk_size = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | n/a | <pre>object({<br>    create              = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network"></a> [k8s\_network](#input\_k8s\_network) | n/a | <pre>object({<br>    create       = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | n/a | yes |
| <a name="input_runtime_policy"></a> [runtime\_policy](#input\_runtime\_policy) | n/a | <pre>object({<br>    create               = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_sysconfig"></a> [sysconfig](#input\_sysconfig) | n/a | <pre>object({<br>    create      = bool<br>    name        = string<br>    ntp_servers = optional(list(string))<br>    dns_servers = optional(list(string))<br>    timezone    = optional(string)<br>    domain_name = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_tr_policy"></a> [tr\_policy](#input\_tr\_policy) | n/a | <pre>object({<br>    create              = bool<br>    name                = string<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_version_policy"></a> [version\_policy](#input\_version\_policy) | n/a | <pre>object({<br>    create  = bool<br>    name    = string<br>    version = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->