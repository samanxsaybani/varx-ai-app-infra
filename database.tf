# # # # Database Resources # # # #

# # SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = local.sql_server_name
  resource_group_name          = azurerm_resource_group.rg_ai_project.name
  location                     = azurerm_resource_group.rg_ai_project.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  minimum_tls_version = "1.2"

  tags = local.common_tags
}

# # SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name      = local.sql_database_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sql_database_sku

  tags = local.common_tags
}

# # SQL Server Firewall Rule - Allow Azure Services
resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = local.sql_firewall_rule_name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# # Key Vault Secret - SQL Connection String
resource "azurerm_key_vault_secret" "sql_connection" {
  name         = "sql-connection-string"
  value        = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_database.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.keyvault.id
  content_type = "connection-string"

  depends_on = [
    azurerm_mssql_database.sql_database,
    azurerm_key_vault.keyvault
  ]
}
