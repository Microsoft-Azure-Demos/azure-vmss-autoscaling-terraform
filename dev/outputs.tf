# VNet resource ID for integrations and operational queries.
output "virtual_network_id" {
  description = "ID of the VMSS virtual network."
  value       = module.networking.virtual_network_id
}

# Subnet ID used by VMSS network interfaces and subnet-level associations.
output "subnet_id" {
  description = "ID of the VMSS subnet."
  value       = module.networking.subnet_id
}

# NSG ID for inspecting the security policy attached to the VMSS subnet.
output "network_security_group_id" {
  description = "ID of the VMSS network security group."
  value       = module.networking.network_security_group_id
}

# NAT Gateway ID for managing outbound connectivity.
output "nat_gateway_id" {
  description = "ID of the VMSS NAT Gateway."
  value       = module.nat_gateway.nat_gateway_id
}

# Stable outbound IP used by instances in the VMSS subnet.
output "nat_gateway_public_ip" {
  description = "Public IP address used by the VMSS NAT Gateway."
  value       = module.nat_gateway.public_ip_address
}

# Load Balancer resource ID for monitoring and integration.
output "load_balancer_id" {
  description = "ID of the VMSS Load Balancer."
  value       = module.load_balancer.load_balancer_id
}

# Backend pool ID required when attaching VMSS instances to the Load Balancer.
output "load_balancer_backend_pool_id" {
  description = "ID of the backend pool to attach to the VMSS."
  value       = module.load_balancer.backend_address_pool_id
}

# Public application endpoint that clients use to reach the Load Balancer.
output "load_balancer_public_ip" {
  description = "Public IP address of the Load Balancer frontend."
  value       = module.load_balancer.public_ip_address
}

# VMSS resource ID for Azure CLI commands and monitoring integrations.
output "vmss_id" {
  description = "ID of the Linux virtual machine scale set."
  value       = module.vmss.id
}

# VMSS name for operational commands and dashboards.
output "vmss_name" {
  description = "Name of the Linux virtual machine scale set."
  value       = module.vmss.name
}

# Autoscale setting ID for inspecting and updating scaling behavior.
output "autoscale_setting_id" {
  description = "ID of the VMSS autoscale setting."
  value       = module.autoscaling.id
}