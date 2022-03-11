output "k8s_cluster_profile_moid" {
  value = intersight_kubernetes_cluster_profile.this.moid
}

output "k8s_cluster_moid" {
  value = intersight_kubernetes_cluster_profile.this.associated_cluster.0.moid
}

output "k8s_cluster_kubeconfig" {
  value = data.intersight_kubernetes_cluster.this.results.0.kube_config
}