# # # # Outputs # # # #

# # Azure OpenAI Outputs
output "openai_endpoint" {
  value       = azurerm_cognitive_account.openai.endpoint
  description = "Azure OpenAI Service endpoint URL"
  sensitive   = false
}

output "openai_api_key" {
  value       = azurerm_cognitive_account.openai.primary_access_key
  description = "Azure OpenAI Service primary API key"
  sensitive   = true
}

# # App Service Outputs
output "app_service_url" {
  value       = "https://${azurerm_linux_web_app.app_service.default_hostname}"
  description = "Chat application URL"
}

output "app_service_name" {
  value       = azurerm_linux_web_app.app_service.name
  description = "App Service name"
}

# # Storage Account Outputs
output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Storage Account name"
}

output "storage_primary_endpoint" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "Storage Account primary blob endpoint"
}

# # Database Outputs
output "sql_server_fqdn" {
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  description = "SQL Server fully qualified domain name"
}

output "sql_database_name" {
  value       = azurerm_mssql_database.sql_database.name
  description = "SQL Database name"
}

# # Key Vault Outputs
output "key_vault_uri" {
  value       = azurerm_key_vault.keyvault.vault_uri
  description = "Key Vault URI"
}

output "key_vault_name" {
  value       = azurerm_key_vault.keyvault.name
  description = "Key Vault name"
}

# # Application Insights Outputs
output "appinsights_instrumentation_key" {
  value       = azurerm_application_insights.insights.instrumentation_key
  description = "Application Insights instrumentation key"
  sensitive   = true
}

output "appinsights_connection_string" {
  value       = azurerm_application_insights.insights.connection_string
  description = "Application Insights connection string"
  sensitive   = true
}

# # Resource Group Outputs
output "resource_group_name" {
  value       = azurerm_resource_group.rg_ai_project.name
  description = "Resource Group name"
}

output "resource_group_location" {
  value       = azurerm_resource_group.rg_ai_project.location
  description = "Resource Group location"
}
