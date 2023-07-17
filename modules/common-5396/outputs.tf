output "Log_Analytics_Workspace" {
    value = azurerm_log_analytics_workspace.log_analytics
}

output "Recovery_Service_Vault" {
    value = azurerm_recovery_services_vault.recovery_vault
}

output "Storage_Account" {
    value = azurerm_storage_account.storage_account
}
