# -------------------------
# APP VM OUTPUTS
# -------------------------

output "vm_app_name" {
  value = azurerm_windows_virtual_machine.vm_app.name
}

output "vm_app_private_ip" {
  value = azurerm_network_interface.nic_app.ip_configuration[0].private_ip_address
}

output "vm_app_public_ip" {
  value = azurerm_public_ip.pip_app.ip_address
}

output "vm_app_id" {
  value = azurerm_windows_virtual_machine.vm_app.id
}

# -------------------------
# WEB VM OUTPUTS
# -------------------------

output "vm_web_name" {
  value = azurerm_windows_virtual_machine.vm_web.name
}

output "vm_web_private_ip" {
  value = azurerm_network_interface.nic_web.ip_configuration[0].private_ip_address
}

output "vm_web_public_ip" {
  value = azurerm_public_ip.pip_web.ip_address
}

output "vm_web_id" {
  value = azurerm_windows_virtual_machine.vm_web.id
}
