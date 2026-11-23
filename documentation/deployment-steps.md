# VMSS Terraform deployment

This Terraform configuration deploys a Linux Virtual Machine Scale Set (VMSS)
and the Azure networking and traffic-management resources it needs. The dev
environment is in `dev/`; reusable resource definitions are in `modules/`.

## Resource flow

Terraform creates these components in dependency order:

1. **Networking** (`modules/networking`): a VNet (`10.0.0.0/16`), a VMSS subnet
   (`10.0.1.0/24`), and an NSG associated with the subnet. The NSG allows inbound
   TCP port 80 from any source.
2. **Outbound access** (`modules/nat-gateway`): a Standard static public IP and
   NAT Gateway associated with the VMSS subnet. The VMSS module explicitly waits
   for this association before creating instances.
3. **Inbound access** (`modules/load-balancer`): a Standard public Load Balancer,
   frontend public IP, backend pool, TCP port 80 health probe, and TCP/80 rule.
4. **Compute** (`modules/vmss`): Ubuntu 22.04 VM instances connected to the
   subnet, Load Balancer backend pool, and health probe. The VMSS uses
   `dev/cloud-init.sh` to install Docker and run the application container.
5. **Autoscaling** (`modules/autoscaling`): scales the VMSS based on average
   CPU over five-minute windows.

The VMSS uses the NSG through its subnet association and outbound connectivity
through the NAT Gateway's subnet association. The Load Balancer backend pool ID
is passed directly to the VMSS network configuration.

## SSH key generation

Generate a dedicated Ed25519 key pair in PowerShell:

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.ssh" | Out-Null
ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\azure_vmss_dev" -C "azure-vmss-dev"
```

If that key file already exists, choose a different filename or back up the
existing key before replacing it. When prompted, use a passphrase to protect
the private key.

Copy the **public** key from
`$env:USERPROFILE\.ssh\azure_vmss_dev.pub` into `dev/terraform.tfvars`:

```hcl
admin_ssh_public_key = "<paste the complete single line from azure_vmss_dev.pub>"
```

Replace the placeholder with the actual public-key line. The VMSS is configured
with the public key; keep the corresponding private key on your machine and
never add it to Terraform files or source control.

For production, manage private keys through an approved secret-management
workflow, such as Azure Key Vault. Avoid exposing private keys in Terraform
state or configuration. The public key itself is not a secret.

## Configuration

Edit [`dev/terraform.tfvars`](dev/terraform.tfvars) for environment-specific
values. It currently sets:

| Input | Value |
| --- | --- |
| `resource_group_name` | `autoscalling-backend-rg` |
| `selected_region` | `germanywestcentral` |
| `admin_ssh_public_key` | Required SSH public key for `azureuser` |

Only provide a **public** SSH key. Do not put a private key or password in
`terraform.tfvars`.

Other defaults are defined in the module variables:

| Component | Defaults |
| --- | --- |
| VNet, subnet, and NSG | `vnet_vmss`, `snet-vmss`, `nsg_vmss`; `10.0.0.0/16`, `10.0.1.0/24` |
| NAT Gateway | `nat-vmss`; Standard static public IP `pip-vmss-nat` |
| Load Balancer | `lb-vmss`; public IP `pip-vmss-lb`; backend pool `backend-vmss` |
| VMSS | `vmss-linux-app`; 2 `Standard_D2alds_v6` instances; admin `azureuser` |
| Autoscaling | minimum 2, default 2, maximum 5 instances |
| Scale-out rule | Average CPU above 70%; add one instance |
| Scale-in rule | Average CPU below 30%; remove one instance |

Autoscale actions use a five-minute metric window and cooldown. Change the
corresponding module variables to adjust these values.

## Deploy

Run these commands from the repository root in PowerShell:

```powershell
Set-Location .\iac-terraform\dev
terraform init -backend-config=backend.hcl
terraform validate
terraform plan
terraform apply
```

The Azure Storage account configured by `backend.hcl` must already exist, and
the identity used by Terraform must be authenticated to Azure. The resource
group must also exist before deployment. `terraform.tfvars` supplies the SSH
public key required by the VMSS.

## Outputs

Useful deployment outputs include:

- `load_balancer_public_ip`: public endpoint for the application.
- `vmss_id` and `vmss_name`: deployed scale set identifiers.
- `subnet_id`, `network_security_group_id`, and `nat_gateway_id`: networking
  resource identifiers.
- `autoscale_setting_id`: autoscale configuration identifier.

The NAT Gateway, public IPs, Load Balancer, and VMSS are billable Azure
resources. Run `terraform destroy` when the environment is no longer needed.

## Implementation details

For an overview of the Azure resources, their purpose, and the architecture and
implementation decisions, see the
[implementation details](documentation/implementation-details.md).