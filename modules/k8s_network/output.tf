output "network_policy_moid" {
  value = intersight_kubernetes_network_policy.this.moid
}
output "sys_config_policy_moid" {
  value = intersight_kubernetes_sys_config_policy.this.moid
}