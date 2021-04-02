# Terraform Intersight Kubernetes Service Module

The Cisco Intersight Terraform Provider is available in the Terraform Registry at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest.  This repository contains example modules that use the provider to create 

A terraform module to create a managed Kubernetes clusters using Intersight Kubernetes Service (IKS). Available through the [Terraform registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest).
<!-- Inspired by and adapted from [this doc](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) -->
and its [source code](https://github.com/CiscoDevNet/terraform-provider-intersight).

## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.
* You are a member of the Early Access Pilot.

## Important Note

This platform is currently in Early Access and comes with no support.  Please contact your Cisco Sales Representative regarding any issues/feature requests.

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**

## Usage Example


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | =1.0.4 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name to be given to the cluster.  This will also prefix all attributes created by this module. | `string` | n/a | yes |
| cni | Supported CNI type. Currently we only support Calico.\* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| domain\_name | Domain Name information for DNS search. | `string` | n/a | yes |
| ip\_gateway | Default gateway for this pool. | `string` | n/a | yes |
| ip\_netmask | Subnet Mask for this pool. | `string` | n/a | yes |
| ip\_pool\_size | Number of IPs you want this pool to contain. | `string` | n/a | yes |
| ip\_primary\_dns | Primary DNS Server for this pool. | `string` | n/a | yes |
| ip\_secondary\_dns | Secondary DNS Server for this pool. | `string` | `""` | no |
| ip\_starting\_address | Starting IP Address you want for this pool. | `string` | n/a | yes |
| organization | Organization Name | `string` | `"default"` | no |
| pod\_cidr | Pod CIDR Block to be used to assign POD IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| root\_ca\_registries | List of root CA certificates. | `list(string)` | `[]` | no |
| service\_cidr | Service CIDR Block used to assign cluster service IP addresses. | `string` | `"100.64.0.0/24"` | no |
| tags | n/a | `list(map(string))` | `[]` | no |
| timezone | The timezone of the node's system clock.  Check Terraform documentation for correct format.  Example America/New\_York | `string` | n/a | yes |
| unsigned\_registries | List of unsigned registries to be supported. | `list(string)` | `[]` | no |
| vc\_cluster | Name of the cluster you wish to make part of this provider within vCenter. | `string` | n/a | yes |
| vc\_datastore | Name of the datastore to be used with this provider. | `string` | n/a | yes |
| vc\_password | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |
| vc\_portgroup | Name of the portgroup(s) to be used in this provider | `list(string)` | n/a | yes |
| vc\_resource\_pool | Name of the resource pool to be used with this provider. | `string` | `""` | no |
| vc\_target\_name | Target name as referenced in Intersight.  vCenter is currently the only supported target. | `string` | n/a | yes |
| worker\_size | Worker size attribute for worker nodes | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->