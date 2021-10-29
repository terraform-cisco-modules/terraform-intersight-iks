# Infrastructure Provider for IKS

This example creates an Infrastructure Provider policy based on the information provided in the module.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
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
| <a name="module_prod_vcenter"></a> [prod\_vcenter](#module\_prod\_vcenter) | terraform-cisco-modules/iks/intersight//modules/infra_provider | 2.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | API Key | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Secret Key or file location | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(map(string))` | `[]` | no |
| <a name="input_vc_password"></a> [vc\_password](#input\_vc\_password) | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->