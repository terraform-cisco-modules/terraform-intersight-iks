data "intersight_organization_organization" "organization" {
  name = var.org_name
}
resource "intersight_kubernetes_virtual_machine_instance_type" "instance" {

  for_each  = { for instance in var.instance_type : instance.name => instance }
  name      = each.value.name
  cpu       = each.value.cpu
  disk_size = each.value.disk
  memory    = each.value.memory
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

