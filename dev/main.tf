# Compose the dev environment from reusable infrastructure modules.
# The resource group must exist before these modules are applied.

# Creates the VNet, VMSS subnet, and subnet-associated network security group.
module "networking" {
  source = "../modules/networking"

  resource_group_name = var.resource_group_name
  selected_region     = var.selected_region
}

# Adds outbound internet access to the VMSS subnet through a NAT Gateway.
module "nat_gateway" {
  source = "../modules/nat-gateway"

  resource_group_name = var.resource_group_name
  selected_region     = var.selected_region
  subnet_id           = module.networking.subnet_id
}

# Creates the public frontend, backend pool, and TCP/80 health probe and rule.
module "load_balancer" {
  source = "../modules/load-balancer"

  resource_group_name = var.resource_group_name
  selected_region     = var.selected_region
}

# Connects instances to the subnet and Load Balancer; cloud-init installs the app.
module "vmss" {
  source = "../modules/vmss"

  resource_group_name     = var.resource_group_name
  selected_region         = var.selected_region
  subnet_id               = module.networking.subnet_id
  backend_address_pool_id = module.load_balancer.backend_address_pool_id
  health_probe_id         = module.load_balancer.health_probe_id
  custom_data             = file("${path.module}/cloud-init.sh")
  admin_ssh_public_key    = var.admin_ssh_public_key

  # Ensure subnet security and NAT associations are ready before VMSS instances boot.
  depends_on = [
    module.networking,
    module.nat_gateway,
  ]
}

# Applies CPU-based scaling rules to the VMSS after it has been created.
module "autoscaling" {
  source = "../modules/autoscaling"

  resource_group_name = var.resource_group_name
  selected_region     = var.selected_region
  vmss_id             = module.vmss.id
}