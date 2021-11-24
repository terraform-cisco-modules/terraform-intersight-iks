# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}
data "intersight_kubernetes_addon_definition" "this" {
  name       = var.addon.addonName
  nr_version = var.addon.releaseVersion
}
# Creating addon Policy
resource "intersight_kubernetes_addon_policy" "this" {
  name        = var.addon.policyName
  description = var.addon.description

  addon_configuration {

    install_strategy  = var.addon.installStrategy
    upgrade_strategy  = var.addon.upgradeStrategy
    override_sets     = var.addon.overrideSets
    overrides         = var.addon.overrides
    release_name      = var.addon.releaseName
    release_namespace = var.addon.releaseNamespace
  }

  addon_definition {
    moid = data.intersight_kubernetes_addon_definition.this.results.0.moid
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
