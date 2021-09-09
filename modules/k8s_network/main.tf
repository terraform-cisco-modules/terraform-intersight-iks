data "intersight_organization_organization" "this" {
  name = var.org_name
}

resource "intersight_kubernetes_network_policy" "this" {


  name             = var.policy_name
  pod_network_cidr = var.pod_cidr
  service_cidr     = var.service_cidr
  cni_type         = var.cni

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