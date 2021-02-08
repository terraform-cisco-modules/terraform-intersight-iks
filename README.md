# intersight-terraform-modules

The Cisco Intersight Terraform Provider is available in the Terraform Registry at https://registry.terraform.io/providers/CiscoDevNet/intersight/latest.  This repository contains example modules that use the provider to create 

A terraform module to create a managed Kubernetes clusters using Intersight Kubernetes Service (IKS). Available through the [Terraform registry](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest).
<!-- Inspired by and adapted from [this doc](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) -->
and its [source code](https://github.com/CiscoDevNet/terraform-provider-intersight).

## Assumptions

* You want to create an IKS cluster on your on-premises infrastructure using Intersight.
* These resources will be provided using Intersight and VMware vCenter 6.7.
* You've claimed vCenter using the Intersight Assist Appliance.
* You are a member of the Early Access Pilot.

## Important Note

This platform is currently in Early Access and comes with no support.  Please contact your Cisco Sales Representative regarding any issues/feature requests.

**Always check [Kubernetes Release Notes](https://kubernetes.io/docs/setup/release/notes/) before updating the major version.**

## Usage Example


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | =0.14.5 |
| intersight | =1.0.0 |

## Providers

No provider.

## Inputs

No input.

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->