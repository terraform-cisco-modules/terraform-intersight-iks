# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}

# Supports IPV4 today.
resource "intersight_ippool_pool" "ip_pool" {
  for_each = { for pool in var.ip_pool_list : pool.name => pool }
  name     = each.value.name
  ip_v4_blocks {
    from = each.value.starting_address
    size = each.value.size
  }
  ip_v4_config {
    netmask       = each.value.netmask
    gateway       = each.value.gateway
    primary_dns   = each.value.dns1
    secondary_dns = each.value.dns2
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}