# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}
# Looking up Asset Target MOID
# data "intersight_asset_target" "infra_target" {

#   name = var.device_name
# }

resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_provider" {
  name        = var.name
  description = var.description
  # infra_config {
  #   # object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
  #   interfaces  = var.vc_portgroup
  #   additional_properties = jsonencode({
  #     Datastore    = var.vc_datastore
  #     Cluster      = var.vc_cluster
  #     Passphrase   = var.vc_password
  #     ResourcePool = var.vc_resource_pool
  #   })
  # }
  node_group {
    moid = var.node_group_moid
  }
  instance_type {

    moid = var.instance_type_moid
  }
  infra_config_policy {
    moid = var.infra_config_policy_moid
  }

  # target {
  #   object_type = "asset.DeviceRegistration"

  #   moid = data.intersight_asset_target.infra_target.results.0.registered_device[0].moid

  # }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}