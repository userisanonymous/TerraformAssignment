output "Windows_AVS_Name" {
  value = azurerm_availability_set.windows_avs.name
}

output "Windows_VM_Hostnames" {
  value = azurerm_windows_virtual_machine.vm_windows[*].name
}

output "Windows_VM_Ids" {
  value = azurerm_windows_virtual_machine.vm_windows[*].id
}

output "Windows_VM_FQDNs" {
  value = [azurerm_public_ip.windows_pip[*].fqdn]
}

output "Windows_Private_IP_Addresses" {
  value = [azurerm_network_interface.windows_nic[*].private_ip_address]
}

output "Windows_Public_IP_Addresses" {
  value = [azurerm_public_ip.windows_pip[*].ip_address]
}

output "Windows_VMs" {
  value = [azurerm_windows_virtual_machine.vm_windows[*].id]
}