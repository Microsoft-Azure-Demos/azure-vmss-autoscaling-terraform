# Existing resource group in which the Load Balancer resources are created.
variable "resource_group_name" {
  description = "Name of the resource group for the Load Balancer."
  type        = string
}

# Azure location shared by the Load Balancer and its public IP.
variable "selected_region" {
  description = "Azure region for the Load Balancer."
  type        = string
}

# Resource name for the public Standard Load Balancer.
variable "load_balancer_name" {
  description = "Name of the Load Balancer."
  type        = string
  default     = "lb-vmss"
}

# Resource name for the public IP that fronts the Load Balancer.
variable "public_ip_name" {
  description = "Name of the Load Balancer frontend public IP."
  type        = string
  default     = "pip-vmss-lb"
}

# Name referenced by the Load Balancer's frontend and its TCP/80 rule.
variable "frontend_name" {
  description = "Name of the Load Balancer frontend IP configuration."
  type        = string
  default     = "frontend-vmss"
}

# Backend pool name used by VMSS network interface configurations.
variable "backend_pool_name" {
  description = "Name of the backend address pool for VMSS instances."
  type        = string
  default     = "backend-vmss"
}