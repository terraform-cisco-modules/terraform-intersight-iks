resource "intersight_kubernetes_node_group_profile" "this" {

  name        = var.name
  action      = var.action
  description = var.description
  node_type   = var.profile_type
  minsize     = var.min_size
  maxsize     = var.max_size
  desiredsize = var.min_size
  ip_pools {
    object_type = "ippool.Pool"
    moid        = var.ip_pool_moid
  }
  kubernetes_version {
    object_type = "kubernetes.VersionPolicy"
    moid        = var.version_moid
  }

  cluster_profile {
    object_type = "kubernetes.ClusterProfile"
    moid        = var.cluster_moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}

