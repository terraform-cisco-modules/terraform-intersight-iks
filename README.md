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
```hcl
use_existing = true
```
If existing objects are not available this module will create those objects for you where required.
Set
```hcl
use_existing = false
```
For the runtime_policies and the Trusted registry, if you DO NOT want to use this policy in your cluster build you need to set the following variable combination in EACH object block.
```hcl
  use_existing         = false
  create_new           = false
```

## Usage

See the [Examples](https://github.com/terraform-cisco-modules/terraform-intersight-iks/tree/main/examples) ---> Complete directory for usage of this module.

There are 4 example files below that are needed to use this module.  Create these files in the same directory, run terraform init.  You will then be ready to run terraform plan or terraform apply.

Change the variables in the terraform.tfvars file and the main.tf as needed.
See the above Examples folder for more information.


Sample main.tf file.  
```hcl
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {

  source  = "terraform-cisco-modules/iks/intersight//"
  version = "~>2.2.2"

# Kubernetes Cluster Profile  Adjust the values as needed.
  cluster = {
    name                = "new_cluster"
    action              = "Unassign"
    wait_for_completion = false
    worker_nodes        = 5
    load_balancers      = 5
    worker_max          = 20
    control_nodes       = 1
    ssh_user            = var.ssh_user
    ssh_public_key      = var.ssh_key
  }


# IP Pool Information (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  ip_pool = {
    use_existing        = true
    name                = "10-239-21-0"
    # ip_starting_address = "10.239.21.220"
    # ip_pool_size        = "20"
    # ip_ending_address   = "10.239.21.239"
    # ip_netmask          = "255.255.255.0"
    # ip_gateway          = "10.239.21.1"
    # dns_servers         = ["10.101.128.15","10.101.128.16"]
  }

# Sysconfig Policy (UI Reference NODE OS Configuration) (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  sysconfig = {
    use_existing = true
    name         = "richfield"
    # domain_name  = "rich.ciscolabs.com"
    # timezone     = "America/New_York"
    # ntp_servers  = ["10.101.128.15"]
    # dns_servers  = ["10.101.128.15"]
  }

# Kubernetes Network CIDR (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  k8s_network = {
    use_existing = true
    name         = "default"

    ######### Below are the default settings.  Change if needed. #########
    # pod_cidr     = "100.65.0.0/16"
    # service_cidr = "100.64.0.0/24"
    # cni          = "Calico"
  }
# Version policy (To create new change "useExisting" to 'false' uncomment variables and modify them to meet your needs.)
  versionPolicy = {
    useExisting = true
    policyName     = "1-19-15-iks.3"
    iksVersionName = "1.19.15-iks.3"
  }
# Trusted Registry Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
# Set both variables to 'false' if this policy is not needed.
  tr_policy = {
    use_existing = false
    create_new   = false
    name         = "trusted-registry"
  }
# Runtime Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
# Set both variables to 'false' if this policy is not needed.
  runtime_policy = {
    use_existing = false
    create_new   = false
    # name                 = "runtime"
    # http_proxy_hostname  = "t"
    # http_proxy_port      = 80
    # http_proxy_protocol  = "http"
    # http_proxy_username  = null
    # http_proxy_password  = null
    # https_proxy_hostname = "t"
    # https_proxy_port     = 8080
    # https_proxy_protocol = "https"
    # https_proxy_username = null
    # https_proxy_password = null
  }

# Infrastructure Configuration Policy (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  infraConfigPolicy = {
    use_existing = true
    # platformType = "iwe"
    # targetName   = "falcon"
    policyName   = "dev"
    # description  = "Test Policy"
    # interfaces   = ["iwe-guests"]
    # vcTargetName   = optional(string)
    # vcClusterName      = optional(string)
    # vcDatastoreName     = optional(string)
    # vcResourcePoolName = optional(string)
    # vcPassword      = optional(string)
  }

# Addon Profile and Policies (To create new change "createNew" to 'true' and uncomment variables and modify them to meet your needs.)
# This is an Optional item.  Comment or remove to not use.  Multiple addons can be configured.
  addons       = [
    {
    createNew = true
    addonPolicyName = "smm-tf"
    addonName            = "smm"
    description       = "SMM Policy"
    upgradeStrategy  = "AlwaysReinstall"
    installStrategy  = "InstallOnly"
    releaseVersion = "1.7.4-cisco4-helm3"
    overrides = yamlencode({"demoApplication":{"enabled":true}})
    },
    # {
    # createNew = true
    # addonName            = "ccp-monitor"
    # description       = "monitor Policy"
    # # upgradeStrategy  = "AlwaysReinstall"
    # # installStrategy  = "InstallOnly"
    # releaseVersion = "0.2.61-helm3"
    # # overrides = yamlencode({"demoApplication":{"enabled":true}})
    # }
  ]

# Worker Node Instance Type (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  instance_type = {
    use_existing = true
    name         = "small"
    # cpu          = 4
    # memory       = 16386
    # disk_size    = 40
  }

# Organization and Tag Information
  organization = var.organization
  tags         = var.tags
}

```
Sample terraform.tfvars file.
```hcl
apikey       = ""
secretkey    = "../../.secret"
organization = "default"
ssh_user = "iksadmin"
ssh_key  = ""
tags = [
  {
    "key" : "managed_by"
    "value" : "Terraform"
  },
  {
    "key" : "owner"
    "value" : "jb"
  }
]
organization = "default" # Change this if a different org is required.  Default org is set to "default"
```

Sample versions.tf file
```hcl
terraform {
  required_version = ">=1.1.0"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.18"
    }
  }
}
```
Sample variables.tf file.
```hcl
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.18 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_addons"></a> [addons](#module\_addons) | ./modules/addon_policy | n/a |
| <a name="module_cluster_addon_profile"></a> [cluster\_addon\_profile](#module\_cluster\_addon\_profile) | ./modules/cluster_addon_profile | n/a |
| <a name="module_cluster_profile"></a> [cluster\_profile](#module\_cluster\_profile) | ./modules/cluster | n/a |
| <a name="module_control_profile"></a> [control\_profile](#module\_control\_profile) | ./modules/node_profile | n/a |
| <a name="module_control_provider"></a> [control\_provider](#module\_control\_provider) | ./modules/infra_provider | n/a |
| <a name="module_infra_config_policy"></a> [infra\_config\_policy](#module\_infra\_config\_policy) | ./modules/infra_config_policy | n/a |
| <a name="module_instance_type"></a> [instance\_type](#module\_instance\_type) | ./modules/worker_profile | n/a |
| <a name="module_ip_pool_policy"></a> [ip\_pool\_policy](#module\_ip\_pool\_policy) | ./modules/ip_pool | n/a |
| <a name="module_k8s_network"></a> [k8s\_network](#module\_k8s\_network) | ./modules/k8s_network | n/a |
| <a name="module_k8s_sysconfig"></a> [k8s\_sysconfig](#module\_k8s\_sysconfig) | ./modules/k8s_sysconfig | n/a |
| <a name="module_k8s_version"></a> [k8s\_version](#module\_k8s\_version) | ./modules/version | n/a |
| <a name="module_runtime_policy"></a> [runtime\_policy](#module\_runtime\_policy) | ./modules/runtime_policy | n/a |
| <a name="module_trusted_registry"></a> [trusted\_registry](#module\_trusted\_registry) | ./modules/trusted_registry | n/a |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | ./modules/node_profile | n/a |
| <a name="module_worker_provider"></a> [worker\_provider](#module\_worker\_provider) | ./modules/infra_provider | n/a |

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
| <a name="input_addons"></a> [addons](#input\_addons) | n/a | <pre>list(object({<br>    createNew        = bool<br>    addonPolicyName  = optional(string)<br>    addonName        = optional(string)<br>    description      = optional(string)<br>    upgradeStrategy  = optional(string)<br>    installStrategy  = optional(string)<br>    overrideSets     = optional(list(map(string)))<br>    overrides        = optional(string)<br>    releaseName      = optional(string)<br>    releaseNamespace = optional(string)<br>    releaseVersion   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>object({<br>    name                = string<br>    action              = string<br>    wait_for_completion = bool<br>    worker_nodes        = number<br>    load_balancers      = number<br>    worker_max          = number<br>    control_nodes       = number<br>    ssh_user            = string<br>    ssh_public_key      = string<br>  })</pre> | n/a | yes |
| <a name="input_infraConfigPolicy"></a> [infraConfigPolicy](#input\_infraConfigPolicy) | n/a | <pre>object({<br>    use_existing       = bool<br>    platformType       = optional(string)<br>    targetName         = optional(string)<br>    policyName         = string<br>    description        = optional(string)<br>    interfaces         = optional(list(string))<br>    diskMode           = optional(string)<br>    vcTargetName       = optional(string)<br>    vcClusterName      = optional(string)<br>    vcDatastoreName    = optional(string)<br>    vcResourcePoolName = optional(string)<br>    vcPassword         = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_infra_config_policy_name"></a> [infra\_config\_policy\_name](#input\_infra\_config\_policy\_name) | Name of existing infra config policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    cpu          = optional(number)<br>    memory       = optional(number)<br>    disk_size    = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | n/a | <pre>object({<br>    use_existing        = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_ending_address   = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network"></a> [k8s\_network](#input\_k8s\_network) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_k8s_network_policy_name"></a> [k8s\_network\_policy\_name](#input\_k8s\_network\_policy\_name) | Name of existing K8s Network Policy (if it exists) to be used. | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_runtime_policy"></a> [runtime\_policy](#input\_runtime\_policy) | n/a | <pre>object({<br>    use_existing         = bool<br>    create_new           = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_sysconfig"></a> [sysconfig](#input\_sysconfig) | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    ntp_servers  = optional(list(string))<br>    dns_servers  = optional(list(string))<br>    timezone     = optional(string)<br>    domain_name  = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_tr_policy"></a> [tr\_policy](#input\_tr\_policy) | n/a | <pre>object({<br>    use_existing        = bool<br>    create_new          = bool<br>    name                = optional(string)<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| <a name="input_versionPolicy"></a> [versionPolicy](#input\_versionPolicy) | n/a | <pre>object({<br>    useExisting    = bool<br>    policyName     = string<br>    iksVersionName = optional(string)<br>    description    = optional(string)<br>    versionName    = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_cluster_moid"></a> [k8s\_cluster\_moid](#output\_k8s\_cluster\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
