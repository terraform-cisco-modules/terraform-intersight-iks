# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}

# Creating Runtime Policy
resource "intersight_kubernetes_container_runtime_policy" "this" {
  name        = var.name
  description = var.description

  docker_bridge_network_cidr = var.docker_bridge_cidr
  docker_http_proxy {
    hostname = var.proxy_http_hostname
    password = var.proxy_http_password
    port     = var.proxy_http_port
    protocol = var.proxy_http_protocol
    username = var.proxy_http_username
  }
  docker_https_proxy {
    hostname = var.proxy_https_hostname
    password = var.proxy_https_password
    port     = var.proxy_https_port
    protocol = var.proxy_https_protocol
    username = var.proxy_https_username
  }
  docker_no_proxy = var.docker_no_proxy
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.this.results.0.moid
  }
}