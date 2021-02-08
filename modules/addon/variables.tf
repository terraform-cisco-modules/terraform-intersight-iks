variable "org_name" {
  type        = string
  description = "Intersight Organization name"
}

variable "addon_name" {
  # Current available addons check documentation for updates
  # kubernetes-dashboard
  # ccp-monitor
  type        = string
  description = "Name of addon to be installed on a Kubernetes cluster.  Current available addons are kubernetes-dashboard and ccp-monitor."
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
  default     = ""
}

variable "tags" {
  type        = list(map(string))
  default     = []
  description = "Tags to be associated with this object in Intersight."
}