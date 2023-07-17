# PostgreSQL Server
resource "azurerm_postgresql_server" "database_server" {
  name                         = var.psql_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku
  version                      = var.database_version
  storage_mb                   = var.database_storage_mb
  administrator_login          = var.database_admin_username
  administrator_login_password = var.database_admin_password
  ssl_enforcement_enabled      = true
  tags                         = local.tags
}

resource "azurerm_postgresql_database" "database" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.database_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
