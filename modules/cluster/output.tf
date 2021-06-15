output "cluster_moid" {
  value = intersight_kubernetes_cluster_profile.this.moid
}
output "k8s_cluster_moid" {
  value = intersight_kubernetes_cluster_profile.this.associated_cluster.0.moid
}