# Create Addons

This example creates addons and based on the information provided in the module.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

The list of supported addons is continuously growing.  Please check the documentation for the most current information.

** Additional ".tf" file examples are located within the GITHUB Repo.  Link Above.

```
provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
module "iks_addon_dashboard" {

  source            = "../../modules/addon_policy"
  addon_policy_name = "dashboard"
  addons            = "kubernetes-dashboard"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}
module "iks_addon_monitor" {

  source            = "../../modules/addon_policy"
  addon_policy_name = "monitor"
  addons            = "ccp-monitor"
  upgrade_strategy  = "AlwaysReinstall"
  install_strategy  = "InstallOnly"
  org_name          = var.organization
  tags              = var.tags
}
```



Note that this example may create resources which are consumed for IKS clusters.  Please make sure to undeploy and delete the cluster before destroying these resources with `terraform destroy`.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.5 |
| intersight | =1.0.7 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_key | API Key | `string` | n/a | yes |
| endpoint | API Endpoint URL | `string` | `"https://www.intersight.com"` | no |
| organization | Organization Name | `string` | `"default"` | no |
| secretkey | Secret Key or file location | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->