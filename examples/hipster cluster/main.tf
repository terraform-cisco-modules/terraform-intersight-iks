provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "./../.."
  # Infra Config Policy Information
  cluster_name     = "hipster"
  cluster_action   = "Deploy"
  vc_target_name   = "wakanda-vcenter.rich.ciscolabs.com"
  vc_portgroup     = ["hipster-dev|hipster-iks|hipster"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password
  # IP Pool Information
  ip_starting_address = "10.139.150.100"
  ip_pool_size        = "20"
  ip_netmask          = "255.255.255.0"
  ip_gateway          = "10.139.150.1"
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
  worker_count = 3
  master_count = 1
  # Organization and Tag
  organization = var.organization
  tags         = var.tags
}


