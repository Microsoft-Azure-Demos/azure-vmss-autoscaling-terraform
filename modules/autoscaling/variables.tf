# Azure resource group containing the target VMSS and autoscale setting.
variable "resource_group_name" {
  description = "Name of the resource group for the autoscale setting."
  type        = string
}

# Region where the autoscale setting is created.
variable "selected_region" {
  description = "Azure region for the autoscale setting."
  type        = string
}

# Resource ID that the CPU metric rules will scale.
variable "vmss_id" {
  description = "ID of the VM scale set to autoscale."
  type        = string
}

# Azure name assigned to the autoscale setting resource.
variable "autoscale_setting_name" {
  description = "Name of the autoscale setting."
  type        = string
  default     = "autoscale-vmss"
}

# Lower capacity bound; scale-in actions stop at this instance count.
variable "minimum_instances" {
  description = "Minimum number of VMSS instances."
  type        = number
  default     = 2
}

# Instance count used as the profile's starting or fallback capacity.
variable "default_instances" {
  description = "Default number of VMSS instances."
  type        = number
  default     = 2
}

# Upper capacity bound; scale-out actions stop at this instance count.
variable "maximum_instances" {
  description = "Maximum number of VMSS instances."
  type        = number
  default     = 5
}

# Scale out by one instance when average CPU exceeds this percentage.
variable "scale_out_cpu_threshold" {
  description = "Average CPU percentage above which the VMSS scales out."
  type        = number
  default     = 70
}

# Scale in by one instance when average CPU falls below this percentage.
variable "scale_in_cpu_threshold" {
  description = "Average CPU percentage below which the VMSS scales in."
  type        = number
  default     = 30
}