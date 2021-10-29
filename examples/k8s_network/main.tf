provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod" {
  source       = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  version      = "2.0.4"
  policy_name  = "prod"
  pod_cidr     = "100.65.0.0/16"
  service_cidr = "100.64.0.0/24"
  cni          = "Calico"
  org_name     = var.organization
  tags         = var.tags
}

