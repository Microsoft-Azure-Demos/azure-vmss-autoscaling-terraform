terraform {
  # This backend bootstrap configuration requires Terraform 1.9 or later.
  required_version = ">= 1.9, < 2.0"

  # Pins compatible provider families used to create the remote-state resources.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

# Configures Azure Resource Manager access using the active Azure credentials.
provider "azurerm" {
  features {
    resource_group {
      # Disabling this safeguard permits deleting a resource group with contents.
      # Protect the remote-state resource group from accidental destruction.
      prevent_deletion_if_contains_resources = false
    }
  }
}
