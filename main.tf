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
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "demo-vnet"
  vnet_cidr           = "10.0.0.0/16"
  subnet_name         = "demo-subnet"
  subnet_cidr         = "10.0.1.0/24"

  //vnet2
  vnet2_name           = "sec-vnet"
  vnet2_cidr           = "20.0.0.0/16"
  subnet2_name         = "sec-subnet"
  subnet2_cidr         = "20.0.1.0/24"
  subnet3_name         = "secthird-subnet"
  subnet3_cidr         = "20.0.2.0/24"

}

