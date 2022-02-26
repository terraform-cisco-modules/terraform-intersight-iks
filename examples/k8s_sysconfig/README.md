# K8s Network Policies

This example create Kubernetes Network and System policies based on the information provided in the module.

## Usage

To run this create a 'main.tf', 'variables.tf' and 'versions.tf' file and place them in the same folder.  Modify the attributes below to meet your needs and run 

```bash
terraform init
terraform plan
terraform apply
```

** Additional ".tf" file examples are located within the GITHUB Repo.  Link Above.

main.tf
```hcl
provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "prod_network" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  policy_name = "prod"
  dns_servers = ["10.101.128.15", "10.101.128.16"]
  ntp_servers = ["10.101.128.15", "10.101.128.16"]
  domain_name = "rich.ciscolabs.com"
  timezone    = "America/New_York"
  org_name    = var.organization
  tags        = var.tags
}
```

Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | =1.0.18 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prod"></a> [prod](#module\_prod) | terraform-cisco-modules/iks/intersight//modules/k8s_sysconfig | n/a |

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

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->