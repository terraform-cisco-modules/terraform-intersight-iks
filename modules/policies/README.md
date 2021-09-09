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
| terraform | >=0.14.5 |
| intersight | >=1.0.11 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| infra\_config\_policy | n/a | <pre>object({<br>    create           = bool<br>    name             = optional(string)<br>    vc_target_name   = optional(string)<br>    vc_cluster       = optional(string)<br>    vc_portgroups    = optional(list(string))<br>    vc_datastore     = optional(string)<br>    vc_resource_pool = optional(string)<br>    vc_password      = optional(string)<br>  })</pre> | n/a | yes |
| instance\_type | n/a | <pre>object({<br>    create    = bool<br>    name      = string<br>    cpu       = optional(number)<br>    memory    = optional(number)<br>    disk_size = optional(number)<br>  })</pre> | n/a | yes |
| ip\_pool | n/a | <pre>object({<br>    create              = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| k8s\_network | n/a | <pre>object({<br>    create       = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| organization | Organization Name | `string` | n/a | yes |
| runtime\_policy | n/a | <pre>object({<br>    create               = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| sysconfig | n/a | <pre>object({<br>    create      = bool<br>    name        = string<br>    ntp_servers = optional(list(string))<br>    dns_servers = optional(list(string))<br>    timezone    = optional(string)<br>    domain_name = optional(string)<br>  })</pre> | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |
| tr\_policy | n/a | <pre>object({<br>    create              = bool<br>    name                = string<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| version\_policy | n/a | <pre>object({<br>    create  = bool<br>    name    = string<br>    version = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->