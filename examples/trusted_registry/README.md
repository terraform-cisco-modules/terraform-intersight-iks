# Kubernetes Trusted Registry Policy

This example creates an IKS Trusted Registry Policy based on the information provided in the module.

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

module "trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  policy_name         = "test"
  unsigned_registries = ["10.139.10.100"]

  org_name = var.organization
  tags     = var.tags
}
```

Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.

Current supported Version is 1.18.12
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | =1.0.13 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apikey | API Key | `string` | n/a | yes |
| endpoint | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| organization | Organization Name | `string` | `"default"` | no |
| secretkey | Secret Key or file location | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->