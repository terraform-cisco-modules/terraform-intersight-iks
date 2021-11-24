# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}
# Loop through and lookup Addon Policy MOID(s)
data "intersight_kubernetes_addon_policy" "this" {
  for_each = {
    for addon in var.addons : addon.addonName => addon
  }
  name = each.key
}
# Create Addon Profile
resource "intersight_kubernetes_cluster_addon_profile" "this" {
  name = var.profile_name

  dynamic "addons" {
    for_each = {
      for addon in var.addons : addon.addonName => addon
    }
    content {
      addon_policy { moid = data.intersight_kubernetes_addon_policy.this[addons.key].results.0["moid"] }
      name = addons.value["addonName"]
      addon_configuration {
        override_sets     = addons.value["overrideSets"]
        overrides         = addons.value["overrides"]
        release_name      = addons.value["releaseName"]
        release_namespace = addons.value["releaseNamespace"]
        install_strategy  = addons.value["installStrategy"]
        upgrade_strategy  = addons.value["upgradeStrategy"]

      }
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