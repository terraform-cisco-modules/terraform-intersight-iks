# Infrastructure Provider for IKS

This example creates an Infrastructure Provider policy based on the information provided in the module.

## Usage

To run this example you need to execute:



```bash
$ terraform init
$ terraform plan
$ terraform apply
```
** Additional ".tf" file examples are located within the GITHUB Repo.  Link Above.

main.tf
```
provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_vcenter" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  name             = "wakanda_vc"
  device_name      = "wakanda-vcenter.rich.ciscolabs.com"
  vc_portgroup     = ["panther|iks|tme"]
  vc_datastore     = "iks"
  vc_cluster       = "tchalla"
  vc_resource_pool = ""
  vc_password      = var.vc_password
  org_name         = var.organization
  tags             = var.tags
}
```


Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | =1.0.17 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prod_vcenter"></a> [prod\_vcenter](#module\_prod\_vcenter) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | 2.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | API Key | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization Name | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Secret Key or file location | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_vc_password"></a> [vc\_password](#input\_vc\_password) | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->