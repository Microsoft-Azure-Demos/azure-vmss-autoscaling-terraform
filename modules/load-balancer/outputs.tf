output "load_balancer_id" {
  description = "ID of the Load Balancer."
  value       = azurerm_lb.vmss.id
}

output "backend_address_pool_id" {
  description = "ID of the backend address pool for VMSS instances."
  value       = azurerm_lb_backend_address_pool.vmss.id
}

output "public_ip_id" {
  description = "ID of the Load Balancer frontend public IP."
  value       = azurerm_public_ip.load_balancer.id
}

output "public_ip_address" {
  description = "Public IP address of the Load Balancer frontend."
  value       = azurerm_public_ip.load_balancer.ip_address
}

output "health_probe_id" {
  description = "ID of the TCP/80 health probe."
  value       = azurerm_lb_probe.http.id
}