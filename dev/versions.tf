# Defines Terraform and provider compatibility and configures remote state.

terraform {
  # Required for the language features used by this configuration.
  required_version = ">= 1.5.0"

  # Constrains provider versions while allowing compatible minor and patch updates.
  required_providers {
    # Manages Azure Resource Manager resources.
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    # Supports resources and APIs not yet covered by AzureRM.
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }

  # Stores Terraform state in Azure Storage; values are supplied by backend.hcl.
  backend "azurerm" {}
}