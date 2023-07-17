resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.linux_name
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  domain_name_label   = each.key
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = toset(["1", "2", "3"])
  tags = local.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }

  tags = local.tags
}


resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each              = var.linux_name
  name                  = each.key
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]
  computer_name         = each.key
  size                  = each.value
  admin_username        = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.pub_key)
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.los_disk_caching
    storage_account_type = var.los_disk_storage_account_type
    disk_size_gb         = var.los_disk_size
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics
  }


  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }

  tags = local.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = var.linux_name
  name     = "LinuxNetworkWatcher"

  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  depends_on           = [azurerm_linux_virtual_machine.vmlinux, null_resource.linux_provisioner]
  tags = local.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each             = var.linux_name
  name                 = "AzureMonitor"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.9"
  depends_on           = [azurerm_linux_virtual_machine.vmlinux, null_resource.linux_provisioner]
  tags = local.tags
}
