output "id" {
  description = "ID of the Linux virtual machine scale set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "name" {
  description = "Name of the Linux virtual machine scale set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss.name
}