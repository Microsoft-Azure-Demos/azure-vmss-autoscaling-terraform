
# Stable Standard public IP used by clients to reach the Load Balancer.
resource "azurerm_public_ip" "load_balancer" {
  name                = var.public_ip_name
  location            = var.selected_region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Standard Load Balancer with a public frontend configuration.
resource "azurerm_lb" "vmss" {
  name                = var.load_balancer_name
  location            = var.selected_region
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.frontend_name
    public_ip_address_id = azurerm_public_ip.load_balancer.id
  }
}

# Pool that the VMSS network interfaces join to receive load-balanced traffic.
resource "azurerm_lb_backend_address_pool" "vmss" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.vmss.id
}

# Checks TCP port 80 so traffic is sent only to responsive backends.
resource "azurerm_lb_probe" "http" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.vmss.id
  protocol        = "Tcp"
  port            = 80
}

# Forwards client TCP port 80 traffic to backend TCP port 80.
resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.vmss.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.vmss.id]
  probe_id                       = azurerm_lb_probe.http.id
}
