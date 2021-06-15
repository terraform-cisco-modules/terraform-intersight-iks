# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}
# Loop through and lookup Addon Policy MOID(s)
data "intersight_kubernetes_addon_policy" "this" {
  count = length(var.addons)
  name  = var.addons[count.index]
}

# Create Addon Profile
resource "intersight_kubernetes_cluster_addon_profile" "this" {
  name = var.profile_name

  dynamic "addons" {
    for_each = data.intersight_kubernetes_addon_policy.this
    content {
      addon_policy {
        moid = addons.value.results.0["moid"]
      }
      name = addons.value.results.0["name"]
    }
  }

  associated_cluster {
    moid = var.cluster_moid
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