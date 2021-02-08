

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.5 |
| intersight | =0.1.5 |

## Providers

| Name | Version |
|------|---------|
| intersight | =0.1.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance\_type | n/a | <pre>list(object({<br>    name   = string,<br>    cpu    = number,<br>    memory = number,<br>    disk   = string<br>  }))</pre> | n/a | yes |
| org\_name | Intersight Organization name | `string` | n/a | yes |
| tags | n/a | `list(map(string))` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->