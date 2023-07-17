resource "azurerm_managed_disk" "linux_data_disk" {
  count                = length(var.linux_vm_ids)
  name                 = "linux-datadisk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.disk_create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}

resource "azurerm_managed_disk" "windows_data_disk" {
  count                = length(var.windows_vm_ids)
  name                 = "windows-datadisk-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.disk_create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}




# Linux VM Data Disk Attachment
resource "azurerm_virtual_machine_data_disk_attachment" "linux_disk_attachment" {
  count              = length(var.linux_vm_ids)
  virtual_machine_id = element(var.linux_vm_ids, count.index)
  managed_disk_id    = azurerm_managed_disk.linux_data_disk[count.index].id
  lun                = 0
  caching            = "None"
}


# Windows VM Data Disk Attachment
resource "azurerm_virtual_machine_data_disk_attachment" "windows_disk_attachment" {
  count              = length(var.windows_vm_ids)
  virtual_machine_id = element(var.windows_vm_ids, count.index)
  managed_disk_id    = azurerm_managed_disk.windows_data_disk[count.index].id
  lun                = 0
  caching            = "None"
}
