
output "firewall_public_ip" {
  value = azurerm_public_ip.firewall_pip.ip_address
}

output "firewall_id" {
  value = azurerm_firewall.firewall.id
}
