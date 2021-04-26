data "intersight_organization_organization" "this" {
  name = var.org_name
}
resource "intersight_kubernetes_virtual_machine_instance_type" "this" {

  name      = var.name
  cpu       = var.cpu
  disk_size = var.disk_size
  memory    = var.memory
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

