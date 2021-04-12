# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}

data "intersight_kubernetes_addon_policy" "addons" {
  # count = length(var.addons)
  # name  = var.addons[count.index]
  name = "dashboard"
}

resource "intersight_kubernetes_cluster_addon_profile" "addon_profile" {
  name = var.profile_name

  # dynamic "addons" {
  #   for_each = data.intersight_kubernetes_addon_policy.addons
  #   content {
  #     addon_policy {
  #       moid = addons.value.results.0["moid"]
  #     }
  #     name = data.intersight_kubernetes_addon_policy.addons.results.0.name
  #   }
  # }
  addons {
    addon_policy {
      # moid = data.intersight_kubernetes_addon_policy.addons.results.0.moid
      moid = "606da03f7a6f722d30525e3b"
    }
    name = "dashboard-test2"
  }

  associated_cluster {
    moid = var.cluster_moid
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results.0.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}