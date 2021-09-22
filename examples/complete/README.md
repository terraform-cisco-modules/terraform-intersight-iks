# Terraform Intersight Kubernetes Cluster Module
This module builds a complete cluster along with all of the required components.

## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.

## Details

This module can create all of the resources required for IKS.  Those resources are identitified below.  It is designed as a quickstart/example of how to get an IKS cluster running.  If all objects are needed they can be created in theis module.  If only certain objects are needed and others reused they can be consumed in this module by setting the "use-exist" flag to "true".

## Objects created
```
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)
* [infrastructure config](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy)
* [Version Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy)
* [ippool](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ippool_pool)
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)
* [Trusted Registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_trusted_registries_policy)
* [runtime-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_container_runtime_policy)
* [Network Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy)


## Usage

main.tf

```
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {

  source = "terraform-cisco-modules/iks/intersight//"


  ip_pool = {
    use_existing        = false
    name                = "ippool"
    ip_starting_address = "10.139.120.220"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "10.139.120.1"
    dns_servers         = ["10.101.128.15"]
  }

  sysconfig = {
    use_existing = false
    name         = "New"
    domain_name  = "rich.ciscolabs.com"
    timezone     = "America/New_York"
    ntp_servers  = ["10.101.128.15"]
    dns_servers  = ["10.101.128.15"]
  }

  k8s_network = {
    use_existing = false
    name         = "default"

    ######### Below are the default settings.  Change if needed. #########
    pod_cidr     = "100.65.0.0/16"
    service_cidr = "100.64.0.0/24"
    cni          = "Calico"
  }
  # Version policy
  version_policy = {
    use_existing = false
    name         = "1.19.5"
    version      = "1.19.5"
  }

  # tr_policy_name = "test"
  tr_policy = {
    use_existing = false
    create_new   = true
    name         = "triggermesh-trusted-registry"
  }
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

  # Infra Config Policy Information
  infra_config_policy = {
    use_existing     = false
    name             = "vcenter"
    vc_target_name   = "marvel-vcsa.rich.ciscolabs.com"
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
    use_existing = false
    name         = "small"
    cpu          = 4
    memory       = 16386
    disk_size    = 40
  }
  # Cluster information
  cluster = {
    name                = "new_cluster"
    action              = "Unassign"
    wait_for_completion = false
    worker_nodes        = 5
    load_balancers      = 5
    worker_max          = 20
    control_nodes       = 1
    ssh_user            = "iksadmin"
    ssh_public_key      = var.ssh_key
  }
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
| intersight | =1.0.13 |

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