provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "k8s_worker_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  name      = "k8s_small"
  cpu       = 4
  memory    = 163843
  disk_size = 40

  org_name = var.organization
  tags     = var.tags
}