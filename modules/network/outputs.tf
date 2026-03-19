output "resource_group_name" {
  value = azurerm_resource_group.rg.name

}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}
output "firewall_subnet" {
  value = azurerm_subnet.firewall_subnet.id
}



output "subnet2_id" {
  value = azurerm_subnet.subnet2.id
}


output "subnet3_id" {
  value = azurerm_subnet.subnet3.id
}


