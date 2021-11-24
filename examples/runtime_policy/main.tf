provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_runtime" {
  source               = "terraform-cisco-modules/iks/intersight//modules/runtime_policy"
  name                 = "tf_runtime"
  proxy_http_hostname  = "esl.proxy.cisco.com"
  proxy_https_hostname = "esl.proxy.cisco.com"
  proxy_http_port      = 80
  proxy_https_port     = 8080
  proxy_https_protocol = "http"
  proxy_http_protocol  = "http"
  org_name             = var.organization
  tags                 = var.tags
}