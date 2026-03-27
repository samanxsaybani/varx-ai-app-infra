# # # # Secure Credential Management # # # #

# # NOTE: Application should retrieve secrets from Key Vault at runtime
# # This approach keeps credentials secure and enables rotation without redeployment

# # Key Vault Secret - SQL Admin Password (for initial setup only - rotate after)
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [azurerm_key_vault.keyvault]
}

# # Key Vault Secret - Storage Account Access Key
resource "azurerm_key_vault_secret" "storage_access_key" {
  name         = "storage-account-key"
  value        = azurerm_storage_account.storage.primary_access_key
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_storage_account.storage
  ]
}

# # Key Vault Secret - OpenAI API Key (Secondary)
resource "azurerm_key_vault_secret" "openai_key_secondary" {
  name         = "openai-api-key-secondary"
  value        = azurerm_cognitive_account.openai.secondary_access_key
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_cognitive_account.openai
  ]
}

# # Add App Service to Key Vault access policy
resource "azurerm_key_vault_access_policy" "app_service_keyvault_access" {
  key_vault_id       = azurerm_key_vault.keyvault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_linux_web_app.app_service.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  certificate_permissions = [
    "Get",
    "List"
  ]

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_linux_web_app.app_service
  ]
}
