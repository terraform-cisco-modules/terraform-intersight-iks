[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/terraform-cisco-modules/terraform-intersight-iks)

# Terraform Intersight Kubernetes Service Module

The Cisco Intersight Terraform Provider is available in the Terraform Registry at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest.  This repository contains example modules that use the provider to create 

A terraform module to create a managed Kubernetes clusters using Intersight Kubernetes Service (IKS). Available through the [Terraform registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest).
<!-- Inspired by and adapted from [this doc](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) -->
and its [source code](https://github.com/CiscoDevNet/terraform-provider-intersight).

## CAVEAT
* You cannot assign the cluster action as "Deploy" and "wait_for_completion" as TRUE at the same time.


## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.

## Details

This module creates all of the resources required for IKS.  Those resources are identitified below.  It is designed as a quickstart/example of how to get an IKS cluster running.  More customization is being enabled but currently there are some caveats:

Reusing prebuilt policies is supported.  Each object block has a variable for doing this.
Set
```
use_existing = true
```
If existing objects are not available this module will create those objects for you where required.
Set
```
use_existing = false
```
For the runtime_policies and the Trusted registry, if you DO NOT want to use this policy in your cluster build you need to set the following variable combination in EACH object block.
```
  use_existing         = false
  create_new           = false
```

## Usage

See the [Examples](https://github.com/terraform-cisco-modules/terraform-intersight-iks/tree/main/examples) ---> Complete directory for usage of this module.

There are 4 example files below that are needed to use this module.  Create these files in the same directory, run terraform init.  You will then be ready to run terraform plan or terraform apply.

Change the variables in the terraform.tfvars file and the main.tf as needed.
See the above Examples folder for more information.


Sample main.tf file.  
```
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "terraform-cisco-modules/iks/intersight//"
  
  ip_pool = {
    use_existing = true
    name = "ippool"
    ip_starting_address = "10.139.120.220"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "10.139.120.1"
    dns_servers         = ["10.101.128.15"]
  }
  
  sysconfig = {
    use_existing = true
    name = "New"
    domain_name = "rich.ciscolabs.com"
    timezone    = "America/New_York"
    ntp_servers = ["10.101.128.15"]
    dns_servers = ["10.101.128.15"] 
  }
  
  k8s_network = {
    use_existing = true
    name = "default"

######### Below are the default settings.  Change if needed. #########
    pod_cidr = "100.65.0.0/16"
    service_cidr = "100.64.0.0/24"
    cni = "Calico"
  }
# Version policy
version_policy = {
  use_existing = true
  name = "1.19.5"
  version = "1.19.5"
}

# tr_policy_name = "test"
  tr_policy = {
    use_existing = true
    name = "triggermesh-trusted-registry"
  }
  runtime_policy = {
    use_existing = true
    name = "runtime"
    http_proxy_hostname = "proxy.com"
    http_proxy_port = 80
    http_proxy_protocol = "http"
    http_proxy_username = null
    http_proxy_password = null
    https_proxy_hostname = "proxy.com"
    https_proxy_port = 8080
    https_proxy_protocol = "https"
    https_proxy_username = null
    https_proxy_password = null
  }
  
  # Infra Config Policy Information
  infra_config_policy = {
    use_existing = true
    name = "vcenter"
    vc_target_name = "marvel-vcsa.rich.ciscolabs.com"
    vc_portgroups    = ["panther|iks|tme"]
    vc_datastore     = "iks"
    vc_cluster       = "tchalla"
    vc_resource_pool = ""
    vc_password      = var.vc_password
  }

  addons_list = [{
    addon_policy_name = "dashboard"
    addon             = "kubernetes-dashboard"
    description       = "K8s Dashboard Policy"
    upgrade_strategy  = "AlwaysReinstall"
    install_strategy  = "InstallOnly"
    },
    {
      addon_policy_name = "monitor"
      addon             = "ccp-monitor"
      description       = "Grafana Policy"
      upgrade_strategy  = "AlwaysReinstall"
      install_strategy  = "InstallOnly"
    }
    {
      addon_policy_name = "smm"
      addon             = "smm"
      description       = "Service Mesh Manager Policy"
      upgrade_strategy  = "AlwaysReinstall"
      install_strategy  = "InstallOnly"

    }
  ]
instance_type = {
  use_existing = true
  name = "small"
  cpu = 4
  memory = 16386
  disk_size = 40 
}
  # Cluster information
  cluster = {
    name = "new_cluster"
    action = "Unassign"
    wait_for_completion = true
    worker_nodes = 5
    load_balancers = 5
    worker_max = 20
    control_nodes = 1
    ssh_user = "iksadmin"
    ssh_public_key = var.ssh_key
  }
  # Organization and Tag
  organization = var.organization
  tags         = var.tags
}
```
Sample terraform.tfvars file.
```
# Required Varilables
apikey       = ""
vc_password  = ""
ssh_user     = "iksadmin"
ssh_key      = ""
# Optional Variables
tags = [
  {
    "key" : "key-1"
    "value" : "value-1"
  },
  {
    "key" : "key-2"
    "value" : "value-2"
  }
]
organization = "default" # Change this if a different org is required.  Default org is set to "default"
```

Sample versions.tf file
```
terraform {
  required_version = ">=0.14.5"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "=1.0.13"
    }
  }
}
```
Sample variables.tf file.
```
variable "apikey" {
  type        = string
  description = "API Key"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
}
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
variable "vc_password" {
  sensitive   = true
  type        = string
  description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
}
variable "tags" {
  type    = list(map(string))
  default = []
}
```

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.17 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.17 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_addons"></a> [addons](#module\_addons) | terraform-cisco-modules/iks/intersight//modules/addon_policy | =2.0.3 |
| <a name="module_cluster_addon_profile"></a> [cluster\_addon\_profile](#module\_cluster\_addon\_profile) | terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile | =2.0.3 |
| <a name="module_cluster_profile"></a> [cluster\_profile](#module\_cluster\_profile) | terraform-cisco-modules/iks/intersight//modules/cluster | =2.0.3 |
| <a name="module_control_profile"></a> [control\_profile](#module\_control\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | =2.0.3 |
| <a name="module_control_provider"></a> [control\_provider](#module\_control\_provider) | terraform-cisco-modules/iks/intersight//modules/infra_provider | =2.0.3 |
| <a name="module_infra_config_policy"></a> [infra\_config\_policy](#module\_infra\_config\_policy) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | =2.0.4 |
| <a name="module_instance_type"></a> [instance\_type](#module\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/worker_profile | =2.0.3 |
| <a name="module_ip_pool_policy"></a> [ip\_pool\_policy](#module\_ip\_pool\_policy) | terraform-cisco-modules/iks/intersight//modules/ip_pool | =2.0.3 |
| <a name="module_k8s_network"></a> [k8s\_network](#module\_k8s\_network) | terraform-cisco-modules/iks/intersight//modules/k8s_network | =2.0.3 |
| <a name="module_k8s_sysconfig"></a> [k8s\_sysconfig](#module\_k8s\_sysconfig) | terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig | =2.0.3 |
| <a name="module_k8s_version"></a> [k8s\_version](#module\_k8s\_version) | terraform-cisco-modules/iks/intersight//modules/version | =2.0.3 |
| <a name="module_runtime_policy"></a> [runtime\_policy](#module\_runtime\_policy) | terraform-cisco-modules/iks/intersight//modules/runtime_policy | =2.0.3 |
| <a name="module_trusted_registry"></a> [trusted\_registry](#module\_trusted\_registry) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | =2.0.3 |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | =2.0.3 |
| <a name="module_worker_provider"></a> [worker\_provider](#module\_worker\_provider) | terraform-cisco-modules/iks/intersight//modules/infra_provider | =2.0.3 |

## Resources

| Name | Type |
|------|------|
| [intersight_ippool_pool.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/ippool_pool) | data source |
| [intersight_kubernetes_container_runtime_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_container_runtime_policy) | data source |
| [intersight_kubernetes_network_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_network_policy) | data source |
| [intersight_kubernetes_sys_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_sys_config_policy) | data source |
| [intersight_kubernetes_trusted_registries_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_trusted_registries_policy) | data source |
| [intersight_kubernetes_version_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_version_policy) | data source |
| [intersight_kubernetes_virtual_machine_infra_config_policy.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_virtual_machine_infra_config_policy) | data source |
| [intersight_kubernetes_virtual_machine_instance_type.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_virtual_machine_instance_type) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons_list"></a> [addons\_list](#input\_addons\_list) | List of objects for each addon to be added. | <pre>list(object({<br>    addon_policy_name = string<br>    addon             = string<br>    description       = string<br>    upgrade_strategy  = string<br>    install_strategy  = string<br>  }))</pre> | `[]` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>object({<br>    name                = string<br>    action              = string<br>    wait_for_completion = bool<br>    worker_nodes        = number<br>    load_balancers      = number<br>    worker_max          = number<br>    control_nodes       = number<br>    ssh_user            = string<br>    ssh_public_key      = string<br>  })</pre> | n/a | yes |
| <a name="input_infraConfigPolicy"></a> [infraConfigPolicy](#input\_infraConfigPolicy) | n/a | <pre>object({<br>    use_existing       = bool<br>    platformType       = optional(string)<br>    targetName         = optional(string)<br>    policyName         = string<br>    description        = optional(string)<br>    interfaces         = optional(list(string))<br>    diskMode           = optional(string)<br>    vcTargetName       = optional(string)<br>    vcClusterName      = optional(string)<br>    vcDatastoreName    = optional(string)<br>    vcResourcePoolName = optional(string)<br>    vcPassword         = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_infra_config_policy_name"></a> [infra\_config\_policy\_name](#input\_infra\_config\_policy\_name) | Name of existing infra config policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    cpu          = optional(number)<br>    memory       = optional(number)<br>    disk_size    = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | n/a | <pre>object({<br>    use_existing        = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network"></a> [k8s\_network](#input\_k8s\_network) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network_policy_name"></a> [k8s\_network\_policy\_name](#input\_k8s\_network\_policy\_name) | Name of existing K8s Network Policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_runtime_policy"></a> [runtime\_policy](#input\_runtime\_policy) | n/a | <pre>object({<br>    use_existing         = bool<br>    create_new           = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_sysconfig"></a> [sysconfig](#input\_sysconfig) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    ntp_servers  = optional(list(string))<br>    dns_servers  = optional(list(string))<br>    timezone     = optional(string)<br>    domain_name  = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_tr_policy"></a> [tr\_policy](#input\_tr\_policy) | n/a | <pre>object({<br>    use_existing        = bool<br>    create_new          = bool<br>    name                = optional(string)<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_version_policy"></a> [version\_policy](#input\_version\_policy) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    version      = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_profile_moid"></a> [cluster\_profile\_moid](#output\_cluster\_profile\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->