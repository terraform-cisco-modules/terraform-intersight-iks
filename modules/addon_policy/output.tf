output "addon_policy" {
  # value = intersight_kubernetes_addon_policy.this.moid
  value = { for k, v in intersight_kubernetes_addon_policy.this : k => v.moid }
  # value = zipmap( values(intersight_kubernetes_addon_policy.this)[*].name,values(intersight_kubernetes_addon_policy.this)[*].moid)
  # value = values(intersight_kubernetes_addon_policy.this)
}
# output "addon_policy_name" {
#   value = intersight_kubernetes_addon_policy.this.name
# }
