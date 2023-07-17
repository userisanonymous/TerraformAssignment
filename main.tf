module "rgroup-5396" {
  source              = "./modules/rgroup-5396"
  resource_group_name = "5396-RG"
  location            = "East US"
}

module "network-5396" {
  source                        = "./modules/network-5396"
  network_name                  = "5396-VNET"
  subnet_name                   = "5396-SUBNET"
  nsg_name                      = "5396-NSG"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_address_space          = ["10.0.0.0/24"]
  resource_group_name           = module.rgroup-5396.Shivam_RG.name
  location                      = module.rgroup-5396.Shivam_RG.location
  depends_on                    = [module.rgroup-5396, ]
}

module "common-5396" {
  source               = "./modules/common-5396"
  log_analytics_name   = "5396-Log-Anaytics"
  recovery_vault_name  = "N01595396-Recovery-Vault"
  storage_account_name = "5396sa"
  log_analytics_sku    = "PerGB2018"
  retention_in_days    = 30
  recovery_vault_sku   = "Standard"
  resource_group_name  = module.rgroup-5396.Shivam_RG.name
  location             = module.rgroup-5396.Shivam_RG.location
  depends_on           = [module.rgroup-5396, ]
}

module "vmlinux-5396" {
  source = "./modules/vmlinux-5396"
  linux_name = {
    n01595396-c-vm1 = "Standard_B1ms"
    n01595396-c-vm2 = "Standard_B1ms"
    n01595396-c-vm3 = "Standard_B1ms"
  }
  admin_username                = "n01595396"
  pub_key                       = "~/.ssh/id_rsa.pub"
  priv_key                      = "~/.ssh/id_rsa"
  los_disk_storage_account_type = "Premium_LRS"
  los_disk_size                 = 32
  los_disk_caching              = "ReadWrite"
  linux_publisher               = "OpenLogic"
  linux_offer                   = "CentOS"
  linux_sku                     = "8_2"
  linux_version                 = "latest"
  resource_group_name           = module.rgroup-5396.Shivam_RG.name
  location                      = module.rgroup-5396.Shivam_RG.location
  subnet_id                     = module.network-5396.Subnet.id
  boot_diagnostics              = module.common-5396.Storage_Account.primary_blob_endpoint

  depends_on = [module.rgroup-5396,
    module.common-5396,
  module.network-5396]
}


module "vmwindows-5396" {
  source                        = "./modules/vmwindows-5396"
  resource_group_name           = module.rgroup-5396.Shivam_RG.name
  location                      = module.rgroup-5396.Shivam_RG.location
  subent_id                     = module.network-5396.Subnet.id
  nb_count                      = 1
  windows_name                  = "n01595396w-vm0"
  size                          = "Standard_B1ms"
  windows_username              = "n01595396"
  windows_password              = "P@$$w0rd1234!"
  wos_disk_storage_account_type = "StandardSSD_LRS"
  wos_disk_size                 = 128
  wos_disk_caching              = "ReadWrite"
  windows_publisher             = "MicrosoftWindowsServer"
  windows_offer                 = "WindowsServer"
  windows_sku                   = "2016-Datacenter"
  windows_version               = "latest"
  windows_avs                   = "my_windows_avs"
  boot_diagnostics              = module.common-5396.Storage_Account.primary_blob_endpoint

  depends_on = [module.rgroup-5396,
    module.common-5396,
  module.network-5396]
}

module "datadisk-5396" {
  source               = "./modules/datadisk-5396"
  resource_group_name  = module.rgroup-5396.Shivam_RG.name
  location             = module.rgroup-5396.Shivam_RG.location
  disk_size_gb         = 10
  storage_account_type = "Standard_LRS"
  disk_create_option   = "Empty"
  linux_vm_names       = module.vmlinux-5396.Linux_VM_Hostnames
  linux_vm_ids         = module.vmlinux-5396.Linux_VM_Ids
  windows_vm_name      = module.vmwindows-5396.Windows_VM_Hostnames
  windows_vm_ids       = module.vmwindows-5396.Windows_VM_Ids
}

module "loadbalancer-5396" {
  source              = "./modules/loadbalancer-5396"
  lb_name             = "assignment-lb"
  lb_pip              = "LoadBalancer-IP"
  resource_group_name = module.rgroup-5396.Shivam_RG.name
  location            = module.rgroup-5396.Shivam_RG.location
  vnet_id             = module.network-5396.Virtual_Network.id
  nic_linux           = module.vmlinux-5396.Linux_NIC
  linux_name          = module.vmlinux-5396.Linux_VM_Hostnames

  depends_on = [module.rgroup-5396,
  module.vmlinux-5396]
}


module "database-5396" {
  source                  = "./modules/database-5396"
  resource_group_name     = module.rgroup-5396.Shivam_RG.name
  location                = module.rgroup-5396.Shivam_RG.location
  database_name           = "shivamdb-5396"
  psql_server_name        = "5396-psql-server"
  sku                     = "GP_Gen5_2"
  database_version        = "11"
  database_storage_mb     = 5120
  database_admin_username = "psqladmin"
  database_admin_password = "P@$$w0rd1234!"

  depends_on = [module.rgroup-5396, ]
}

