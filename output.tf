output "k8s_cluster_moid" {
  value = module.cluster_profile.k8s_cluster_moid
}

output "k8s_cluster_profile_moid" {
  value = module.cluster_profile.k8s_cluster_profile_moid
}

output "k8s_cluster_kubeconfig" {
  value     = module.cluster_profile.k8s_cluster_kubeconfig
  sensitive = true
}

output "k8s_cluster_host" {
  value = try(yamldecode(base64decode(module.cluster_profile.k8s_cluster_kubeconfig)).clusters[0].cluster.server, "")
}

output "k8s_cluster_ca_certificate" {
  value     = try(base64decode(yamldecode(base64decode(module.cluster_profile.k8s_cluster_kubeconfig)).clusters[0].cluster.certificate-authority-data), "")
  sensitive = true
}

output "k8s_cluster_client_certificate" {
  value     = try(base64decode(yamldecode(base64decode(module.cluster_profile.k8s_cluster_kubeconfig)).users[0].user.client-certificate-data), "")
  sensitive = true
}

output "k8s_cluster_client_key" {
  value     = try(base64decode(yamldecode(base64decode(module.cluster_profile.k8s_cluster_kubeconfig)).users[0].user.client-key-data), "")
  sensitive = true
}