provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_runtime" {
  source = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"

  name                 = "tf_runtime"
  proxy_http_hostname  = "test"
  proxy_https_hostname = "test"
  org_name             = var.organization
  tags                 = var.tags
}