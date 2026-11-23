resource "azurerm_public_ip" "nat" {
  name                = var.public_ip_name
  location            = var.selected_region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "vmss" {
  name                = var.nat_gateway_name
  location            = var.selected_region
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "vmss" {
  nat_gateway_id       = azurerm_nat_gateway.vmss.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "vmss" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.vmss.id
}