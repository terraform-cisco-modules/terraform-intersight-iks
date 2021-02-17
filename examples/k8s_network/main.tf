provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_network" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  policy_name = "prod"
  dns_servers = ["10.101.128.15", "10.101.128.16"]
  ntp_servers = ["10.101.128.15", "10.101.128.16"]
  domain_name = "rich.ciscolabs.com"
  timezone    = "America/New_York"
  org_name    = var.organization
  tags        = var.tags
}

