variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}
variable "addon_policy_name" {
  type        = string
  description = "Name of the Addon Policy to be created."
}
variable "addons" {
  type        = string
  default     = ""
  description = "Addon to be added to the policy.  See Terraform documentation for list of supported addons."
}
variable "description" {
  type        = string
  default     = ""
  description = "Description to be used to describe the addon policy"
}
variable "upgrade_strategy" {
  # Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.
  type        = string
  description = "Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.* UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.* NoAction - This choice enables No upgrades to be performed.* ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.* AlwaysReinstall - Always remove older release and reinstall."
}
variable "install_strategy" {
  # Addon install strategy to determine whether an addon is installed if not present.
  type        = string
  description = "Addon install strategy to determine whether an addon is installed if not present.* InstallOnly - Only install in green field. No action in case of failure or removal.* NoAction - No install action performed.* Always - Attempt install if chart is not already installed."
}
variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}
