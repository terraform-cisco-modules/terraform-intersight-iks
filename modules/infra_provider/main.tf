
resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "this" {
  name        = var.name
  description = var.description

  node_group {
    moid = var.node_group_moid
  }
  instance_type {

    moid = var.instance_type_moid
  }
  infra_config_policy {
    moid = var.infra_config_policy_moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}