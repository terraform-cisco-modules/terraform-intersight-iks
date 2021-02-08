# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}


data "intersight_kubernetes_addon" "addon" {
  # Loops through addons list to get the Moid to add to the policy
  count = length(var.addons)
  name  = var.addons[count.index]
}

# Creating addon Policy by from the addons in the addon list 
resource "intersight_kubernetes_addon_policy" "addon_policy" {
  name = var.addon_policy_name
  dynamic "addons" {
    for_each = data.intersight_kubernetes_addon.addon
    content {
      moid = addons.value["id"]
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}