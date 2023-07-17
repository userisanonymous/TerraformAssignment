output "Shivam_RG_Name" {
  value = module.rgroup-5396.Shivam_RG.name
}

output "Shivam_VNET_Name" {
  value = module.network-5396.Virtual_Network.name
}

output "Shivam_Subnet_Name" {
  value = module.network-5396.Subnet.name
}

output "Log_Analytics_Workspace_Name" {
  value = module.common-5396.Log_Analytics_Workspace.name
}

output "Recovery_Service_Vault_Name" {
  value = module.common-5396.Recovery_Service_Vault.name
}

output "Storage_Account_Name" {
  value = module.common-5396.Storage_Account.name
}

output "Storage_Account_URI" {
    value = module.common-5396.Storage_Account.primary_blob_endpoint
}

output "Linux_VM_Hostnames" {
  value = module.vmlinux-5396.Linux_VM_Hostnames
}

output "Linux_FQDN" {
  value = module.vmlinux-5396.Linux_VM_FQDNs
}

output "Linux_Private_Address" {
 value = module.vmlinux-5396.Linux_Private_IP_Addresses
}

output "Linux_Public_Address" {
  value = module.vmlinux-5396.Linux_Public_IP_Addresses
}

output "Linux_Zone" {
  value = module.vmlinux-5396.Linux_Zone
}

output "Windows_Hostnames" {
  value = module.vmwindows-5396.Windows_VM_Hostnames  
}

output "Windows_FQDN" {
  value = module.vmwindows-5396.Windows_VM_FQDNs
}

output "Windows_Private_Address" {
  value = module.vmwindows-5396.Windows_Private_IP_Addresses
}

output "Windows_Public_Address" {
  value = module.vmwindows-5396.Windows_Public_IP_Addresses 
}

output "Windows_AVS" {
  value = module.vmwindows-5396.Windows_AVS_Name
}

output "Load_Balancer_Name" {
  value = module.loadbalancer-5396.Load_Balancer.name  
}

output "Database_Name" {
  value = module.database-5396.Database_Name
}

output "Database_Server_Name" {
  value = module.database-5396.Database_Server_Name
}

output "Linux_Data_Disk_Name" {
  value = module.datadisk-5396.Linux_Data_Disk_Name
}

output "Windows_Data_Disk_Name" {
  value = module.datadisk-5396.Windows_Data_Disk_Name
}