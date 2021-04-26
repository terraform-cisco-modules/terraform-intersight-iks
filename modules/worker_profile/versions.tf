terraform {
  required_version = ">= 0.14.5"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.7"
    }
  }
}