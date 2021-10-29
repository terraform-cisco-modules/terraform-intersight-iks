# Looking up Organization MOID
data "intersight_organization_organization" "this" {
  name = var.org_name
}
# Looking up Asset Target MOID
data "intersight_asset_target" "this" {
  name = var.vmConfig.targetName
}

resource "intersight_kubernetes_virtual_machine_infra_config_policy" "this" {
  name        = var.vmConfig.policyName
  description = var.vmConfig.description
  vm_config {
    interfaces = var.vmConfig.interfaces
    additional_properties = jsonencode({

      Datastore    = var.vmConfig.vcDatastoreName
      Cluster      = var.vmConfig.vcClusterName
      Passphrase   = var.vmConfig.vcPassword
      ResourcePool = var.vmConfig.vcResourcePoolName

    })
    # object_type = "kubernetes.HyperFlexApVirtualMachineInfraConfig"
    object_type = trimspace(<<-EOT
      %{if lower(var.vmConfig.platformType) == "esxi"~}${"kubernetes.EsxiVirtualMachineInfraConfig"}%{endif~}
      %{if lower(var.vmConfig.platformType) == "iwe"~}${"kubernetes.HyperFlexApVirtualMachineInfraConfig"}%{endif~}
      EOT
    )

  }
  target {
    object_type = "asset.DeviceRegistration"
    moid        = data.intersight_asset_target.this.results.0.registered_device[0].moid
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
  organization {
    moid = data.intersight_organization_organization.this.results.0.moid
  }
}