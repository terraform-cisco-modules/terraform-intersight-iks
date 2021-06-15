# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}

data "intersight_kubernetes_addon_definition" "this" {
  for_each = { for addon in var.addons : addon.addon_policy_name => addon }
  name     = each.value.addon
}
# Creating addon Policy
resource "intersight_kubernetes_addon_policy" "this" {

  for_each    = { for addon in var.addons : addon.addon_policy_name => addon }
  name        = each.value.addon_policy_name
  description = each.value.description

  addon_configuration {
    install_strategy = each.value.install_strategy
    upgrade_strategy = each.value.upgrade_strategy
  }

  addon_definition {
    moid = data.intersight_kubernetes_addon_definition.this[each.key].results.0.moid
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
    moid        = data.intersight_organization_organization.this.results.0.moid
  }
}
