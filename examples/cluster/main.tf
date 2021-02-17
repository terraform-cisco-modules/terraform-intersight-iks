provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
# terraform {
#   backend "remote" {
#     organization = "Cisco-ITS-TigerTeam"

#     workspaces {
#       name = "cl21-test"
#     }
#   }
# }

data "terraform_remote_state" "dev_infra" {
  backend = "remote"

  config = {
    organization = "Cisco-ITS-TigerTeam"
    workspaces = {
      name = "richfield-iks-infra-dev"
    }
  }
}


# module "dev_cluster" {
#   source = "terraform-cisco-modules/iks/intersight//modules/cluster"
#   name = "dev"
#   action = "Deploy"
#   ip_pool_moid = data.terraform_remote_state.dev_infra.outputs.ip_pool_moid
#   load_balancer = 1
#   ssh_key = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBl8AgXK9Ypm5prmzRnuhDs9WqExSDOsoduwQYVF6jSqheKnDv4ThPXTp2xWkVIhRFwOjFXuHYOF7E35cOy/c34= jusbarks@JUSBARKS-M-D2JU"
#   ssh_user = "iksadmin"
#   addon_policy_moid = data.terraform_remote_state.dev_infra.outputs.addon_policy_moid
#   net_config_moid = data.terraform_remote_state.dev_infra.outputs.network_policy_moid
#   sys_config_moid = data.terraform_remote_state.dev_infra.outputs.sys_config_policy_moid

#   org_name         = var.organization
#   tags             = var.tags
# }

# module "master_profile" {
#   source = "terraform-cisco-modules/iks/intersight//modules/node_profile"
#   name = "master_dev"
#   profile_type = "Master"
#   desired_size = 1
#   infra_moid = data.terraform_remote_state.dev_infra.outputs.infra_provider_small_moid
#   ip_pool_moid = data.terraform_remote_state.dev_infra.outputs.ip_pool_moid
#   version_moid = data.terraform_remote_state.dev_infra.outputs.version_policy_moid
#   cluster_moid = module.dev_cluster.cluster_moid
#   org_name         = var.organization
#   tags             = var.tags
# }

# module "worker_profile" {
#   source = "terraform-cisco-modules/iks/intersight//modules/node_profile"
#   name = "worker_dev"
#   profile_type = "Worker"
#   desired_size = 1
#   infra_moid = data.terraform_remote_state.dev_infra.outputs.infra_provider_small_moid
#   ip_pool_moid = data.terraform_remote_state.dev_infra.outputs.ip_pool_moid
#   version_moid = data.terraform_remote_state.dev_infra.outputs.version_policy_moid
#   cluster_moid = module.dev_cluster.cluster_moid
#   org_name         = var.organization
#   tags             = var.tags
# }