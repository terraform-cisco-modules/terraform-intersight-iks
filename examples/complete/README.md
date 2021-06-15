# Terraform Intersight Kubernetes Cluster Module
This module builds a complete cluster along with all of the required components.

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
3.  2 DNS and 2 NTP servers are required.  If you do not have 2, list the single DNS and NTP server twice.
4.  The 

## Usage

main.tf

```
provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "terraform-cisco-modules/iks/intersight//"
  # Infra Config Policy Information
  cluster_name = "tn"
  cluster_action = "Deploy"
  vc_target_name   = "wakanda-vcenter.rich.ciscolabs.com"
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
  ip_primary_dns      = "10.101.128.15"
  ip_secondary_dns    = "10.101.128.16"

  # Network Configuration Settings
  # pod_cidr = "100.65.0.0/16"
  # service_cidr = "100.64.0.0/24"
  # cni = "Calico"
  domain_name         = "rich.ciscolabs.com"
  timezone            = "America/New_York"
  unsigned_registries = ["10.101.128.128"]
  # root_ca_registries  = [""]

  # Cluster information
  ssh_user     = var.ssh_user
  ssh_key      = var.ssh_key
  worker_size  = "small"
  worker_count = 4
  master_count = 1
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
| intersight | =1.0.9 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apikey | API Key | `string` | n/a | yes |
| endpoint | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| organization | Organization Name | `string` | `"default"` | no |
| secretkey | Secret Key or file location | `string` | n/a | yes |
| ssh\_key | SSH Public Key to be used to node login. | `string` | n/a | yes |
| ssh\_user | SSH Username for node login. | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |
| vc\_password | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_moid | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->