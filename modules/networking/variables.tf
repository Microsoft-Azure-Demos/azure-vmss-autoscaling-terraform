
variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
  default     = "vnet_vmss"
}

variable "subnet_name" {
  description = "Name of the VMSS subnet."
  type        = string
  default     = "snet-vmss"
}

variable "nsg_name" {
  description = "Name of the network security group."
  type        = string
  default     = "nsg_vmss"
}

variable "selected_region" {
  description = "Azure region for the virtual network."
  type        = string
  default     = "germanywestcentral"
}

variable "resource_group_name" {
  description = "Name of the resource group for the virtual network."
  type        = string
  default     = "autoscalling-backend-rg"
}

variable "address_space" {
  description = "Address spaces assigned to the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the VMSS subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

