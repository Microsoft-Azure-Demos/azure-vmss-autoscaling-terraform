variable "resource_group_name" {
  description = "Name of the resource group for the NAT Gateway resources."
  type        = string
}

variable "selected_region" {
  description = "Azure region for the NAT Gateway resources."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet that will use the NAT Gateway."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the NAT Gateway public IP."
  type        = string
  default     = "pip-vmss-nat"
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  type        = string
  default     = "nat-vmss"
}