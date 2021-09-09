# Reuseable Policies

This example Reuseable policies that can be consumed by one or more IKS cluster.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
** Additional ".tf" file examples are located within the GITHUB Repo.  Link Above.

main.tf
```
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "kubernetes" {
  source           = "terraform-cisco-modules/iks/intersight//modules/policies"
  
  # Kubernetes Version Policy
  version_policy = {
    create = true
    name = "1.19.5"
    version = "1.19.5"
  }

  # IKS Infra Config Policy
  infra_config_policy = {
    create = true
    name = "vcenter"
    vc_target_name = "marvel-vcsa.rich.ciscolabs.com"
    vc_portgroups    = ["panther|iks|tme"]
    vc_datastore     = "iks"
    vc_cluster       = "tchalla"
    vc_resource_pool = ""
    vc_password      = var.vc_password
  }

  # Intersight IP Pool Policy
  ip_pool = {
    create = true
    name = "ippool"
    ip_starting_address = "10.139.120.220"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "10.139.120.1"
    dns_servers         = ["10.101.128.15"]
  }

sysconfig = {
    create = true
    name = "New"
    domain_name = "rich.ciscolabs.com"
    timezone    = "America/New_York"
    ntp_servers = ["10.101.128.15"]
    dns_servers = ["10.101.128.15"] 
  }
  k8s_network = {
    create = true
    name = "default"
    pod_cidr = "100.65.0.0/16"
    service_cidr = "100.64.0.0/24"
    cni = "Calico"
  }
instance_type = {
  create = true
  name = "small"
  cpu = 4
  memory = 16384
  disk_size = 40 
}
  
  # Trusted Registry Policy
  tr_policy = {
    create = true
    name = "triggermesh-trusted-registry"
  }

  # Runtime Policy

  runtime_policy = {
    create = true
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
  
  # Core configuration components
  organization = var.organization
  tags     = var.tags
}

```
variables.tf
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

versions.tf
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

Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | =1.0.13 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apikey | API Key | `string` | n/a | yes |
| endpoint | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| organization | Organization Name | `string` | n/a | yes |
| secretkey | Secret Key or file location | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |
| vc\_password | vCenter Password | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->