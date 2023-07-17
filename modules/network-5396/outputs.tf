output "Virtual_Network" {
  value = azurerm_virtual_network.shivam_vnet
}

output "Subnet" {
  value = azurerm_subnet.shivam_subnet
}

output "Subent_Address_Space" {
  value = azurerm_subnet.shivam_subnet
}

output "Network_Security_Group" {
  value = azurerm_network_security_group.shivam_nsg
}
