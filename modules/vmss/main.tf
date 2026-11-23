
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmss_name
  resource_group_name             = var.resource_group_name
  location                        = var.selected_region
  sku                             = var.vm_size
  instances                       = var.instance_count
  admin_username                  = var.admin_username
  upgrade_mode                    = "Automatic"
  disable_password_authentication = true
  custom_data                     = base64encode(replace(var.custom_data, "\r\n", "\n"))
  health_probe_id                 = var.health_probe_id

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.vmss_name}-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_address_pool_id]
    }
  }
}
