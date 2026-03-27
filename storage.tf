# # # # Storage & Security Resources # # # #

# # Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg_ai_project.name
  location                 = azurerm_resource_group.rg_ai_project.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  tags = local.common_tags
}

# # Storage Container for Chat Logs
resource "azurerm_storage_container" "chat_logs" {
  name                  = "chat-logs"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}

# # Storage Container for Uploads
resource "azurerm_storage_container" "uploads" {
  name                  = "user-uploads"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}

# # Key Vault
resource "azurerm_key_vault" "keyvault" {
  name                = local.keyvault_name
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  location            = azurerm_resource_group.rg_ai_project.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.keyvault_sku

  soft_delete_retention_days   = 7
  purge_protection_enabled     = false
  rbac_authorization_enabled   = true

  tags = local.common_tags
}

# # Key Vault Secret - Azure OpenAI Key
resource "azurerm_key_vault_secret" "openai_key" {
  name         = "openai-api-key"
  value        = azurerm_cognitive_account.openai.primary_access_key
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_cognitive_account.openai
  ]
}

# # Key Vault Secret - Azure OpenAI Endpoint
resource "azurerm_key_vault_secret" "openai_endpoint" {
  name         = "openai-endpoint"
  value        = azurerm_cognitive_account.openai.endpoint
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_cognitive_account.openai
  ]
}

# # Key Vault Secret - Storage Account Connection String
resource "azurerm_key_vault_secret" "storage_connection" {
  name         = "storage-connection-string"
  value        = azurerm_storage_account.storage.primary_connection_string
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_storage_account.storage
  ]
}

# # Get current Azure client context for RBAC
data "azurerm_client_config" "current" {}
