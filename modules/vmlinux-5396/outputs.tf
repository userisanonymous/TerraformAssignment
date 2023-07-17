output "Linux_VM_Hostnames" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].name
}

output "Linux_VM_Ids" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].id
}

output "Linux_VM_FQDNs" {
  value = values(azurerm_public_ip.linux_pip)[*].fqdn
}

output "Linux_Private_IP_Addresses" {
  value = values(azurerm_network_interface.linux_nic)[*].private_ip_address
}

output "Linux_Public_IP_Addresses" {
  value = values(azurerm_public_ip.linux_pip)[*].ip_address
}

output "Linux_Public_IP" {
  value = values(azurerm_public_ip.linux_pip)[*]
}

output "Linux_NIC" {
  value = values(azurerm_network_interface.linux_nic)[*].id
}

output "Linux_Zone" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].zone
}

output "IP_Configuration" {
  value = values(azurerm_network_interface.linux_nic)[*].ip_configuration[0]
}