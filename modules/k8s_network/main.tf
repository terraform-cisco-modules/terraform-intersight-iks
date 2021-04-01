data "intersight_organization_organization" "organization" {
  name = var.org_name
}

resource "intersight_kubernetes_network_policy" "k8s_network_pod_policy" {


  name             = join("", [var.policy_name, "_pod"])
  pod_network_cidr = var.pod_cidr
  service_cidr     = var.service_cidr
  cni_type         = var.cni

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results.0.moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}

resource "intersight_kubernetes_sys_config_policy" "k8s_system_config_policy" {

  name            = join("", [var.policy_name, "_network"])
  dns_servers     = var.dns_servers
  ntp_servers     = var.ntp_servers
  timezone        = var.timezone
  dns_domain_name = var.domain_name

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results.0.moid
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value["key"]
      value = tags.value["value"]
    }
  }
}