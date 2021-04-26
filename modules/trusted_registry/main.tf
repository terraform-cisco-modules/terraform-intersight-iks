data "intersight_organization_organization" "this" {
  name = var.org_name
}

resource "intersight_kubernetes_trusted_registries_policy" "this" {


  name                = var.policy_name
  root_ca_registries  = var.root_ca_registries
  unsigned_registries = var.unsigned_registries
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