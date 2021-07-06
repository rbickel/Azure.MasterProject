# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "rbickeltfstate"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }  
}

provider "azurerm" {
  features {}
}
