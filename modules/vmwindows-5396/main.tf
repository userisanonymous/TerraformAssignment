resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = local.tags
}

resource "azurerm_network_interface" "windows_nic" {
  count               = var.nb_count
  name                = "${var.windows_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.windows_name}-ipconfig-${format("%1d", count.index + 1)}"
    subnet_id                     = var.subent_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.windows_pip[*].id, count.index + 1)
  }

  tags = local.tags
}

resource "azurerm_public_ip" "windows_pip" {
  count               = var.nb_count
  name                = "${var.windows_name}-pip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  domain_name_label   = "${var.windows_name}${format("%1d", count.index + 1)}"
  allocation_method   = "Dynamic"

  tags = local.tags
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  count                 = var.nb_count
  name                  = "${var.windows_name}${format("%1d", count.index + 1)}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [element(azurerm_network_interface.windows_nic[*].id, count.index + 1)]
  computer_name         = "${var.windows_name}${format("%1d", count.index + 1)}"
  size                  = var.size
  admin_username        = var.windows_username
  admin_password        = var.windows_password

  os_disk {
    name                 = "${var.windows_name}-os-disk-${format("%1d", count.index + 1)}"
    caching              = var.wos_disk_caching
    storage_account_type = var.wos_disk_storage_account_type
    disk_size_gb         = var.wos_disk_size
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics
  }

  source_image_reference {
    publisher = var.windows_publisher
    offer     = var.windows_offer
    sku       = var.windows_sku
    version   = var.windows_version
  }

  winrm_listener {
    protocol = "Http"
  }
}

resource "azurerm_virtual_machine_extension" "windows_antimalware" {
  count                      = var.nb_count
  name                       = "Windows_Antimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_windows[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = "true"
  settings                   = <<SETTINGS
        {
            "AntimalwareEnabled": true,
            "RealtimeProtectionEnabled": "true",
            "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "1",
            "time": "120",
            "scanType": "Quick"
            },
        "Exclusions": {
        "Extensions": "",
        "Paths": "",
        "Processes": ""
        }
    }
SETTINGS


  tags = local.tags
}
