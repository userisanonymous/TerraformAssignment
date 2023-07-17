output "Database_Server_Name" {
  value = azurerm_postgresql_server.database_server.name
}

output "Database_Name" {
  value = azurerm_postgresql_database.database.name
}