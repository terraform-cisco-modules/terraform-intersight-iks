# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}
data "intersight_kubernetes_addon_definition" "addon" {
  name = var.addons
}
# Creating addon Policy
resource "intersight_kubernetes_addon_policy" "addon_policy" {
  name        = var.addon_policy_name
  description = var.description

  addon_configuration {
    install_strategy = var.install_strategy
    upgrade_strategy = var.upgrade_strategy
  }

  addon_definition {
    moid = data.intersight_kubernetes_addon_definition.addon.results.0.moid
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
    moid        = data.intersight_organization_organization.organization.results.0.moid
  }
}