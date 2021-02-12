data "intersight_organization_organization" "organization" {
  name = var.org_name
}
resource "intersight_kubernetes_virtual_machine_instance_type" "instance" {

  name      = var.name
  cpu       = var.cpu
  disk_size = var.disk_size
  memory    = var.memory
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}

