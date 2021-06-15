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
module "addons" {

  source            = "terraform-cisco-modules/iks/intersight//modules/addon_policy"
  addons = [{
    addon_policy_name = "dashboard"
    addon = "kubernetes-dashboard"
    description = "K8s Dashboard Policy"
    upgrade_strategy = "AlwaysReinstall"
    install_strategy = "InstallOnly"
  },
  {
    addon_policy_name = "monitor"
    addon = "ccp-monitor"
    description = "Grafana Policy"
    upgrade_strategy = "AlwaysReinstall"
    install_strategy = "InstallOnly"
  }
  ]

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
| intersight | =1.0.9 |

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

| Name | Description |
|------|-------------|
| addon\_policy | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->