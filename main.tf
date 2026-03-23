terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateabubakar12345"
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
  vnet_name           = "Hub-vnet"
  vnet_cidr           = "10.0.0.0/16"
  subnet_name         = "hub-subnet"
  subnet_cidr         = "10.0.1.0/24"
  bastion_subnet_name = "AzureBastionSubnet"
  bastion_subnet_cidr = "10.0.3.0/27"

  firewall_subnet_name = "AzureFirewallSubnet"
  firewall_subnet      = "10.0.4.0/26"
  // Web-Spoke
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
  resource_group_name = var.resource_group_name
  location            = var.location

  subnet3_id = module.network.subnet3_id
  subnet2_id = module.network.subnet2_id
}

//bastion

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = var.resource_group_name
  location            = var.location

  # If bastion subnet is created in network module:
  bastion_subnet_id = module.network.bastion_subnet_id
}


//firewalll
module "firewall" {
  source              = "./modules/firewall"
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_subnet = module.network.firewall_subnet
}


//UDR

module "udr_web" {
  source              = "./modules/udr"
  resource_group_name = var.resource_group_name
  location            = var.location

  route_table_name    = "rt-web"
  subnet_id           = module.network.subnet2_id
  firewall_private_ip = module.firewall.firewall_private_ip
}

module "udr_product" {
  source              = "./modules/udr"
  resource_group_name = var.resource_group_name
  location            = var.location

  route_table_name    = "rt-product"
  subnet_id           = module.network.subnet3_id
  firewall_private_ip = module.firewall.firewall_private_ip
}



module "log_analytics" {
  source              = "./modules/log_analytics"
  resource_group_name = var.resource_group_name
  location            = var.location

  workspace_name     = "demo-law"
  retention_in_days  = 30
}

