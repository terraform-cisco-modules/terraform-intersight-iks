provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_runtime" {
  source = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"

  name                 = "tf_runtime"
  proxy_http_hostname  = "esl.proxy.cisco.com"
  proxy_https_hostname = "esl.proxy.cisco.com"
  proxy_http_port      = 80
  proxy_https_port     = 8080
  org_name             = var.organization
  tags                 = var.tags
}