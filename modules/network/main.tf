resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
//vnet hub
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

//firewall

  resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     =  [var.firewall_subnet]  // [var.firewall_subnet_prefix]
}


//bastiion subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 =   var.bastion_subnet_name  //AzureBastionSubnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/27"] # adjust to your hub VNet range
}


//vnet2 web-spoke
resource "azurerm_virtual_network" "vnet2" {
  name                = var.vnet2_name
  address_space       = [var.vnet2_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = [var.subnet2_cidr]
}
//vnet3 proudct-spoke
resource "azurerm_virtual_network" "vnet3" {
  name                = var.vnet3_name
  address_space       = [var.vnet3_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "subnet3" {
  name                 = var.subnet3_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes     = [var.subnet3_cidr]
}



// perring 

//product to hub
resource "azurerm_virtual_network_peering" "hubToprod" {

  name                      = "mypeer"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id

  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}
resource "azurerm_virtual_network_peering" "prodTohub" {

  name                      = "mysecpeer"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id

  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}


//web to hub

resource "azurerm_virtual_network_peering" "hubToweb" {

  name                      = "webToHub "
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet3.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id

  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}
resource "azurerm_virtual_network_peering" "webToHub" {

  name                      = "hubToweb"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet3.id

  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  allow_virtual_network_access = true
}

