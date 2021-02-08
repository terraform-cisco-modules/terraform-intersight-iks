terraform {
  required_version = ">= 0.14.5"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "=0.1.5"
    }
  }
}