# Terraform Intersight Kubernetes Service Module

The Cisco Intersight Terraform Provider is available in the Terraform Registry at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest.  This repository contains example modules that use the provider to create 

A terraform module to create a managed Kubernetes clusters using Intersight Kubernetes Service (IKS). Available through the [Terraform registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest).
<!-- Inspired by and adapted from [this doc](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) -->
and its [source code](https://github.com/CiscoDevNet/terraform-provider-intersight).


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
    action = "Deploy"
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
      version = "=1.0.11"
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
| terraform | >=0.14.5 |
| intersight | >=1.0.13 |

## Providers

| Name | Version |
|------|---------|
| intersight | >=1.0.13 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addons\_list | List of objects for each addon to be added. | <pre>list(object({<br>    addon_policy_name = string<br>    addon             = string<br>    description       = string<br>    upgrade_strategy  = string<br>    install_strategy  = string<br>  }))</pre> | `[]` | no |
| cluster | n/a | <pre>object({<br>    name                = string<br>    action              = string<br>    wait_for_completion = bool<br>    worker_nodes        = number<br>    load_balancers      = number<br>    worker_max          = number<br>    control_nodes       = number<br>    ssh_user            = string<br>    ssh_public_key      = string<br>  })</pre> | n/a | yes |
| infra\_config\_policy | n/a | <pre>object({<br>    use_existing     = bool<br>    name             = optional(string)<br>    vc_target_name   = optional(string)<br>    vc_cluster       = optional(string)<br>    vc_portgroups    = optional(list(string))<br>    vc_datastore     = optional(string)<br>    vc_resource_pool = optional(string)<br>    vc_password      = optional(string)<br>  })</pre> | n/a | yes |
| infra\_config\_policy\_name | Name of existing infra config policy (if it exists) to be used. | `string` | `""` | no |
| instance\_type | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    cpu          = optional(number)<br>    memory       = optional(number)<br>    disk_size    = optional(number)<br>  })</pre> | n/a | yes |
| ip\_pool | n/a | <pre>object({<br>    use_existing        = bool<br>    name                = string<br>    ip_starting_address = optional(string)<br>    ip_pool_size        = optional(string)<br>    ip_netmask          = optional(string)<br>    ip_gateway          = optional(string)<br>    dns_servers         = optional(list(string))<br>  })</pre> | n/a | yes |
| k8s\_network | n/a | <pre>object({<br>    use_existing = bool<br>    name         = optional(string)<br>    pod_cidr     = optional(string)<br>    service_cidr = optional(string)<br>    cni          = optional(string)<br>  })</pre> | n/a | yes |
| k8s\_network\_policy\_name | Name of existing K8s Network Policy (if it exists) to be used. | `string` | `""` | no |
| organization | Organization Name | `string` | `"default"` | no |
| runtime\_policy | n/a | <pre>object({<br>    use_existing         = bool<br>    name                 = optional(string)<br>    http_proxy_hostname  = optional(string)<br>    http_proxy_port      = optional(number)<br>    http_proxy_protocol  = optional(string)<br>    http_proxy_username  = optional(string)<br>    http_proxy_password  = optional(string)<br>    https_proxy_hostname = optional(string)<br>    https_proxy_port     = optional(number)<br>    https_proxy_protocol = optional(string)<br>    https_proxy_username = optional(string)<br>    https_proxy_password = optional(string)<br>    docker_no_proxy      = optional(list(string))<br>  })</pre> | n/a | yes |
| sysconfig | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    ntp_servers  = optional(list(string))<br>    dns_servers  = optional(list(string))<br>    timezone     = optional(string)<br>    domain_name  = optional(string)<br>  })</pre> | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |
| tr\_policy | n/a | <pre>object({<br>    use_existing        = bool<br>    name                = string<br>    root_ca_registries  = optional(list(string))<br>    unsigned_registries = optional(list(string))<br>  })</pre> | n/a | yes |
| version\_policy | n/a | <pre>object({<br>    use_existing = bool<br>    name         = string<br>    version      = optional(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->