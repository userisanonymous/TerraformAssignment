output "Linux_Data_Disk_Name" {
  value = azurerm_managed_disk.linux_data_disk[*].name
}

output "Windows_Data_Disk_Name" {
  value = azurerm_managed_disk.windows_data_disk[*].name
}