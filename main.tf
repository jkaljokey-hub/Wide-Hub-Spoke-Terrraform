terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateabubakar123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location

  // Hub
  vnet_name     = "Hub-vnet"
  vnet_cidr     = "10.0.0.0/16"
  subnet_name   = "hub-subnet"
  subnet_cidr   = "10.0.1.0/24"

  // Web-Spokes
  vnet2_name   = "web-spoke"
  vnet2_cidr   = "20.0.0.0/16"
  subnet2_name = "sec-subnet"
  subnet2_cidr = "20.0.1.0/24"

  // Product-Spoke
  vnet3_name   = "product-spoke"
  vnet3_cidr   = "30.0.0.0/16"
  subnet3_name = "product-subnet"
  subnet3_cidr = "30.0.1.0/24"
}

// Product VM
module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  subnet3_id = module.network.subnet1_id
  subnet2_id = module.network.subnet2_id
}