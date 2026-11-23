output "nat_gateway_id" {
  description = "ID of the NAT Gateway."
  value       = azurerm_nat_gateway.vmss.id
}

output "public_ip_id" {
  description = "ID of the NAT Gateway public IP."
  value       = azurerm_public_ip.nat.id
}

output "public_ip_address" {
  description = "Public IP address used by the NAT Gateway."
  value       = azurerm_public_ip.nat.ip_address
}