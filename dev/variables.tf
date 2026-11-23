variable "resource_group_name" {
  description = "The name of the existing resource group for the VMSS environment."
  type        = string
  default     = "autoscalling-backend-rg"
}

variable "selected_region" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "germanywestcentral"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the VMSS administrator."
  type        = string
}
