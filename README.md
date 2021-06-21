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

1.  Re-using IP Pools is not available in this module yet.  *this is a work in progress
2.  Currently 3 "t-shirt" sizes are built
    1.  Small - 4vcpu, 16GB Memory, 40GB Disk
    2.  Medium - 8vcpu, 24GB Memory, 60GB Disk
    3.  Large - 12vcpu, 32GB Memory, 80GB Disk

## Usage

See the [Examples](https://github.com/terraform-cisco-modules/terraform-intersight-iks/tree/main/examples) ---> Complete directory for usage of this module.

Sample main.tf file.  Change variables as needed.  See the above Exapmles folder for more information.

```
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "terraform-cisco-modules/iks/intersight//modules/terraform-intersight-iks/"
  # source = "terraform-cisco-modules/iks/intersight//"
  # Infra Config Policy Information
  cluster_name = "test0614"
  # cluster_action   = "Deploy"
  vc_target_name   = "marvel-vcsa.rich.ciscolabs.com"
  vc_portgroup     = ["panther|triggerMesh|tme"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password

  # IP Pool Information
  ip_starting_address = "10.139.120.220"
  ip_pool_size        = "20"
  ip_netmask          = "255.255.255.0"
  ip_gateway          = "10.139.120.1"
  ntp_servers         = ["10.101.128.15"]
  dns_servers         = ["10.101.128.15"]

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
  # Network Configuration Settings
  # pod_cidr = "100.65.0.0/16"
  # service_cidr = "100.64.0.0/24"
  # cni = "Calico"
  domain_name = "rich.ciscolabs.com"
  timezone    = "America/New_York"


  # Trusted Registry Entry
  # unsigned_registries = ["10.101.128.128"]
  # root_ca_registries  = [""]

  # Cluster information
  ssh_user       = var.ssh_user
  ssh_key        = var.ssh_key
  worker_size    = "medium"
  worker_count   = 4
  master_count   = 1
  load_balancers = 3
  # Organization and Tag
  organization = var.organization
  tags         = var.tags
}
```


**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**


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
| addons\_list | List of objects for each addon to be added. | <pre>list(object({<br>    addon_policy_name = string<br>    addon             = string<br>    description       = string<br>    upgrade_strategy  = string<br>    install_strategy  = string<br>  }))</pre> | `[]` | no |
| cluster\_action | Cluster action wanted (ex. Deploy or Unassign) | `string` | `"Unassign"` | no |
| cluster\_name | Name to be given to the cluster.  This will also prefix all attributes created by this module. | `string` | n/a | yes |
| cni | Supported CNI type. Currently we only support Calico.\* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| dns\_servers | List of DNS Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| docker\_no\_proxy | Networks excluded from the proxy. | `list(string)` | `[]` | no |
| domain\_name | Domain Name information for DNS search. | `string` | n/a | yes |
| ip\_gateway | Default gateway for this pool. | `string` | n/a | yes |
| ip\_netmask | Subnet Mask for this pool. | `string` | n/a | yes |
| ip\_pool\_size | Number of IPs you want this pool to contain. | `string` | n/a | yes |
| ip\_starting\_address | Starting IP Address you want for this pool. | `string` | n/a | yes |
| k8s\_version | Kubernetes Version to be installed | `string` | `"1.19.5"` | no |
| load\_balancers | Number of load\_balancers for the cluster. | `number` | `3` | no |
| master\_count | Number of master nodes | `number` | `1` | no |
| ntp\_servers | List of NTP Servers to be included in the Network Policy. | `list(string)` | n/a | yes |
| organization | Organization Name | `string` | `"default"` | no |
| pod\_cidr | Pod CIDR Block to be used to assign POD IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| proxy\_http\_hostname | HTTP Proxy server FQDN or IP. | `string` | `""` | no |
| proxy\_http\_password | The password for the HTTP Proxy. | `string` | `""` | no |
| proxy\_http\_port | The HTTP Proxy port number.The port number of the HTTP proxy must be between 1 and 65535, inclusive. | `number` | `8080` | no |
| proxy\_http\_protocol | Protocol to use for the HTTPS Proxy. | `string` | `"http"` | no |
| proxy\_http\_username | The username for the HTTP Proxy. | `string` | `""` | no |
| proxy\_https\_hostname | HTTPS Proxy server FQDN or IP. | `string` | `""` | no |
| proxy\_https\_password | The password for the HTTPS Proxy. | `string` | `""` | no |
| proxy\_https\_port | The HTTPS Proxy port number.The port number of the HTTPS proxy must be between 1 and 65535, inclusive. | `number` | `8443` | no |
| proxy\_https\_protocol | Protocol to use for the HTTPS Proxy. | `string` | `"https"` | no |
| proxy\_https\_username | The username for the HTTPS Proxy. | `string` | `""` | no |
| root\_ca\_registries | List of root CA certificates. | `list(string)` | `[]` | no |
| service\_cidr | Service CIDR Block used to assign cluster service IP addresses. | `string` | `"100.64.0.0/24"` | no |
| ssh\_key | SSH Public Key to be used to node login. | `string` | n/a | yes |
| ssh\_user | SSH Username for node login. | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |
| timezone | The timezone of the node's system clock.  Check Terraform documentation for correct format.  Example America/New\_York | `string` | n/a | yes |
| unsigned\_registries | List of unsigned registries to be supported. | `list(string)` | `[]` | no |
| vc\_cluster | Name of the cluster you wish to make part of this provider within vCenter. | `string` | n/a | yes |
| vc\_datastore | Name of the datastore to be used with this provider. | `string` | n/a | yes |
| vc\_password | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |
| vc\_portgroup | Name of the portgroup(s) to be used in this provider | `list(string)` | n/a | yes |
| vc\_resource\_pool | Name of the resource pool to be used with this provider. | `string` | `""` | no |
| vc\_target\_name | Target name as referenced in Intersight.  vCenter is currently the only supported target. | `string` | n/a | yes |
| wait\_for\_completion | Wait for cluster completion true/false | `bool` | `false` | no |
| worker\_count | Number of worker nodes wanted for the cluster. | `number` | `2` | no |
| worker\_max | Maximum number of worker nodes in a cluster. | `number` | `50` | no |
| worker\_size | Worker size attribute for worker nodes | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->