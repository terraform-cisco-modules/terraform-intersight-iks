# Terraform Intersight Kubernetes Cluster Module
This module builds a complete cluster along with all of the required components.

## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.

## Details

This example creates all of the resources required for IKS.  Those resources are identitified below.  It is designed as a quickstart/example of how to get an IKS cluster running.  If all objects are needed they can be created in theis module.  If only certain objects are needed and others reused they can be consumed in this module by setting the "use-exist" flag to "true".  Please note the comments in each section for additional context.

## Objects created

* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)
* [infrastructure config](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infra_config_policy)
* [Version Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_version_policy)
* [ippool](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ippool_pool)
* [System Config Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_sys_config_policy)
* [Trusted Registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_trusted_registries_policy)
* [runtime-policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_container_runtime_policy)
* [Network Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_network_policy)


## CAVEAT
* You cannot assign the cluster action as "Deploy" and "wait_for_completion" as TRUE at the same time.

## Usage
To run this create a 'main.tf', 'variables.tf' and 'versions.tf' file and place them in the same folder.  Modify the attributes below to meet your needs and run 

```bash
terraform init
terraform plan
terraform apply
```


main.tf

```hcl
provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_cluster" {
  source  = "terraform-cisco-modules/iks/intersight//"
  version = "2.1.2"

  # Kubernetes Cluster Profile  Adjust the values as needed.
  cluster = {
    name                = "test"
    action              = "Unassign"
    wait_for_completion = false
    worker_nodes        = 2
    load_balancers      = 5
    worker_max          = 20
    control_nodes       = 1
    ssh_user            = var.ssh_user
    ssh_public_key      = var.ssh_key
  }

  # IP Pool Information (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  ip_pool = {
    use_existing = true
    name         = "marvel-prod"
    # ip_starting_address = "10.239.21.220"
    # ip_pool_size        = "20"
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

  # Version policy (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  versionPolicy = {
    useExisting    = false
    policyName     = "1.19.15"
    iksVersionName = "1.19.15-iks.3"
  }

  # Trusted Registry Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
  # Set both variables to 'false' if this policy is not needed.
  tr_policy = {
    use_existing = false
    create_new   = false
    # name         = "trusted-registry"
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
    policyName = "marvel-prod"
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
  addons = [
    {
      createNew       = false
      addonPolicyName = "smm"
      addonName       = "smm"
      # description     = "SMM Policy"
      # upgradeStrategy = "AlwaysReinstall"
      # installStrategy = "InstallOnly"
      # releaseVersion  = "1.7.4-cisco4-helm3"
      overrides = yamlencode({ "demoApplication" : { "enabled" : true } })
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

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | =1.0.19 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/iks/intersight// | 2.1.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | API Key | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Secret Key or file location | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public Key to be used to node login. | `string` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH Username for node login. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_vc_password"></a> [vc\_password](#input\_vc\_password) | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_cluster_moid"></a> [k8s\_cluster\_moid](#output\_k8s\_cluster\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->