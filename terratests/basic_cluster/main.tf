terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    intersight = {
      source = "CiscoDevNet/intersight"
    }
  }
}

provider "intersight" {
  apikey    = var.intersight_apikey
  secretkey = var.intersight_secretkey
  endpoint  = var.intersight_endpoint
}

module "main" {
  source = "../.."

  # Kubernetes Cluster Profile  
  cluster = {
    name                = var.name
    action              = "Unassign"
    wait_for_completion = true
    worker_nodes        = 5
    load_balancers      = 4
    worker_max          = 20
    control_nodes       = 1
    ssh_user            = "testiksadmin"
    ssh_public_key      = "12345"
  }


  # IP Pool Information 
  ip_pool = {
    use_existing        = false
    name                = var.name
    ip_starting_address = "10.1.1.10"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "10.1.1.1"
    dns_servers         = ["8.8.8.8", "8.8.4.4"]
  }

  # Sysconfig Policy 
  sysconfig = {
    use_existing = false
    name         = var.name
    domain_name  = "test.ciscolabs.com"
    timezone     = "America/New_York"
    ntp_servers  = ["pool.ntp.org"]
    dns_servers  = ["8.8.8.8", "8.8.4.4"]
  }

  # Kubernetes Network CIDR 
  k8s_network = {
    use_existing = false
    name         = var.name

    pod_cidr     = "2.2.0.0/16"
    service_cidr = "3.3.3.0/24"
    cni          = "Calico"
  }
  # Version policy 
  versionPolicy = {
    useExisting    = false
    policyName     = var.name
    iksVersionName = "1.20.14-iks.0"
  }
  # Trusted Registry Policy 
  tr_policy = {
    use_existing = false
    create_new   = false
    name         = var.name
  }
  # Runtime Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
  # Set both variables to 'false' if this policy is not needed.
  runtime_policy = {
    use_existing = false
    create_new   = false
    name         = var.name
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
    use_existing = false
    policyName   = var.name
    platformType = "esxi"
    # targetName         = "prodvcenter.ceclab.info"
    targetName         = "10.67.17.125"
    description        = "Infra config policy for ${var.name}"
    interfaces         = ["vm-network-28"]
    vcTargetName       = "prodvcenter.ceclab.info"
    vcClusterName      = "Melb-HX-Hybrid"
    vcDatastoreName    = "cgascoig-1"
    vcResourcePoolName = ""
    vcPassword         = var.vsphere_password
  }

  # Addon Profile and Policies (To create new change "createNew" to 'true' and uncomment variables and modify them to meet your needs.)
  # This is an Optional item.  Comment or remove to not use.  Multiple addons can be configured.
  addons = [
    # {
    #   createNew       = true
    #   addonPolicyName = "smm-tf"
    #   addonName       = "smm"
    #   description     = "SMM Policy"
    #   upgradeStrategy = "AlwaysReinstall"
    #   installStrategy = "InstallOnly"
    #   releaseVersion  = "1.7.4-cisco4-helm3"
    #   overrides       = yamlencode({ "demoApplication" : { "enabled" : true } })
    # },
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
    use_existing = false
    name         = var.name
    cpu          = 4
    memory       = 16386
    disk_size    = 40
  }

  # Organization and Tag Information
  organization = "default"
  tags         = []
}

variable "vsphere_password" {
  sensitive = true
}
variable "intersight_apikey" {
  sensitive = true
}
variable "intersight_secretkey" {
  sensitive = true
}
variable "intersight_endpoint" {
  sensitive = true
}
variable "name" {
  default = "test_basic_cluster"
}

output "k8s_cluster_profile_moid" {
  value = module.main.k8s_cluster_profile_moid
}

output "k8s_cluster_moid" {
  value = module.main.k8s_cluster_moid
}