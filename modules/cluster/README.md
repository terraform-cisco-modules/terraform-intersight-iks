# Cluster Profile Creation

## Usage

```hcl
module "iks_cluster_profile" {

  source = "terraform-cisco-modules/iks/intersight//modules/cluster"

  # omitted...
}
```

This module is used to create IKS clusters.  It can be used standalone or with all of the other modules in this repo.  If it is used standalone, the lookups for the various MOIDs will need to be added.


These resources are created

* [cluster_profile](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_profile)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.18 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_kubernetes_cluster_profile.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_profile) | resource |
| [intersight_kubernetes_cluster.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/kubernetes_cluster) | data source |
| [intersight_organization_organization.this](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Action for cluster. i.e 'Deploy' 'Unassign' | `string` | `"Unassign"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description to be used to describe the cluster profile. | `string` | `""` | no |
| <a name="input_ip_pool_moid"></a> [ip\_pool\_moid](#input\_ip\_pool\_moid) | MOID derived from the IP Pool that is being consumed. | `string` | n/a | yes |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | Number of load balancer addresses to deploy. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the IKS Cluster to be deployed. | `string` | n/a | yes |
| <a name="input_net_config_moid"></a> [net\_config\_moid](#input\_net\_config\_moid) | MOID for the Network Config Policy that is being consumed. | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Intersight Organization name | `string` | n/a | yes |
| <a name="input_runtime_policy_moid"></a> [runtime\_policy\_moid](#input\_runtime\_policy\_moid) | MOID for the Runtime Policy that is being consumed. | `string` | `""` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public Key to be used to node login. | `string` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH Username for node login. | `string` | n/a | yes |
| <a name="input_sys_config_moid"></a> [sys\_config\_moid](#input\_sys\_config\_moid) | MOID for the System Config Policy that is being consumed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated with this object in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_trusted_registry_policy_moid"></a> [trusted\_registry\_policy\_moid](#input\_trusted\_registry\_policy\_moid) | MOID for the Trusted Registry Policy that is being consumed. | `string` | `""` | no |
| <a name="input_wait_for_completion"></a> [wait\_for\_completion](#input\_wait\_for\_completion) | Wait for cluster completion true/false | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_cluster_kubeconfig"></a> [k8s\_cluster\_kubeconfig](#output\_k8s\_cluster\_kubeconfig) | n/a |
| <a name="output_k8s_cluster_moid"></a> [k8s\_cluster\_moid](#output\_k8s\_cluster\_moid) | n/a |
| <a name="output_k8s_cluster_profile_moid"></a> [k8s\_cluster\_profile\_moid](#output\_k8s\_cluster\_profile\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->