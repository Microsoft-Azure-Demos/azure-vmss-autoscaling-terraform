variable "resource_group_name" {
  description = "Name of the resource group for the VM scale set."
  type        = string
}

variable "selected_region" {
  description = "Azure region for the VM scale set."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet used by the VM scale set."
  type        = string
}

variable "backend_address_pool_id" {
  description = "ID of the Load Balancer backend pool for the VM scale set."
  type        = string
}

variable "health_probe_id" {
  description = "ID of the Load Balancer health probe for the VM scale set."
  type        = string
}

variable "custom_data" {
  description = "Cloud-init script content passed to each VM instance."
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key used to authenticate the VMSS administrator."
  type        = string
}

variable "vmss_name" {
  description = "Name of the Linux virtual machine scale set."
  type        = string
  default     = "vmss-linux-app"
}

variable "vm_size" {
  description = "Azure VM size for each scale set instance."
  type        = string
  default     = "Standard_D2alds_v6"
  #Standard_D2alds_v6 - 2 vcpus, 4 GiB memory ($69.50)
}

variable "instance_count" {
  description = "Initial number of VMSS instances."
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Administrator username for each VMSS instance."
  type        = string
  default     = "azureuser"
}