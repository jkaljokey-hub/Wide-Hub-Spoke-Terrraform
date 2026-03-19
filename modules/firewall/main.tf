resource "azurerm_public_ip" "firewall_pip" {
  name                = "firewall-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "fw_policy" {
  name                = "fw-policy"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall" "firewall" {
  name                = "hub-firewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = var.firewall_subnet
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }

  firewall_policy_id = azurerm_firewall_policy.fw_policy.id
}