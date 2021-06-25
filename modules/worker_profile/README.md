# worker_profile - Intersight IKS Worker Profile Policy Terraform Module

## Usage

```hcl
module "iks_worker_profile" {

  source = "terraform-cisco-modules/iks/intersight//modules/worker_profile"

  # omitted...
}
```

This module will create a VM Instance Policy for IKS.  This policy can then be used to create IKS clusters.  This can be used to create "t-shirt" sizes for the worker nodes.  (i.e small, medium, large, x-large, etc...)


These resources are created
* [VM Instance Policy](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_instance_type)



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->