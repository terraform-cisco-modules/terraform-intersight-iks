# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}

# Supports IPV4 today.
resource "intersight_ippool_pool" "this" {
  name = var.name
  ip_v4_blocks {
    from = var.starting_address
    size = var.pool_size
  }
  ip_v4_config {
    netmask       = var.netmask
    gateway       = var.gateway
    primary_dns   = var.primary_dns
    secondary_dns = var.secondary_dns
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.this.results.0.moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}