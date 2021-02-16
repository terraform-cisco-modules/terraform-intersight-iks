output "network_policy_moid" {
  value = intersight_kubernetes_network_policy.k8s_network_pod_policy.moid
}
output "sys_config_policy_moid" {
  value = intersight_kubernetes_sys_config_policy.k8s_system_config_policy.moid
}