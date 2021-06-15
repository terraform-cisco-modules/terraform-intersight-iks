provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "terraform-cisco-modules/iks/intersight"
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


