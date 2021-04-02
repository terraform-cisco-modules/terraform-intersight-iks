# Looking up Organization MOID
data "intersight_organization_organization" "organization" {
  name = var.org_name
}

# Creating cluster policy
resource "intersight_kubernetes_cluster_profile" "cluster" {

  name                = var.name
  description         = var.description
  action              = var.action
  wait_for_completion = var.wait_for_completion
  cluster_ip_pools {
    moid = var.ip_pool_moid
  }
  container_runtime_config {
    moid = var.runtime_policy_moid
  }
  management_config {
    load_balancer_count = var.load_balancer
    ssh_keys = [
      var.ssh_key
    ]
    ssh_user = var.ssh_user
  }
  # addons {
  #   moid = var.addon_policy_moid
  # }
  trusted_registries {
    moid = var.trusted_registry_policy_moid
  }
  net_config {
    moid = var.net_config_moid
  }
  sys_config {
    moid = var.sys_config_moid
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
    moid        = data.intersight_organization_organization.organization.results.0.moid
  }
}
