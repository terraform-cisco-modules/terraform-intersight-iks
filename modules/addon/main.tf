# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}
data "intersight_kubernetes_addon_definition" "addon_def" {
  # Current available addons check documentation for updates
  # kubernetes-dashboard
  # CCP-Monitor
  # EFK

  name = var.addon_name
}
# Creating addons
resource "intersight_kubernetes_addon" "addon" {

  name             = data.intersight_kubernetes_addon_definition.addon_def.name
  upgrade_strategy = var.upgrade_strategy
  install_strategy = var.install_strategy
  addon_definition {
    moid = data.intersight_kubernetes_addon_definition.addon_def.moid
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