# # # # Azure OpenAI Service & AI Resources # # # #

# # Azure OpenAI Service
resource "azurerm_cognitive_account" "openai" {
  name                = local.azure_openai_name
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  location            = azurerm_resource_group.rg_ai_project.location
  kind                = "OpenAI"
  sku_name            = var.azure_openai_sku

  tags = local.common_tags
}

# # Azure AI Services (for content moderation, language detection, etc.)
resource "azurerm_cognitive_account" "ai_services" {
  name                = "ai-${local.resource_prefix}"
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  location            = azurerm_resource_group.rg_ai_project.location
  kind                = "CognitiveServices"
  sku_name            = "S0"

  tags = local.common_tags
}

# # Container Registry (for hosting Foundry agents)
resource "azurerm_container_registry" "acr" {
  name                = local.container_registry_name
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  location            = azurerm_resource_group.rg_ai_project.location
  sku                 = var.container_registry_sku
  admin_enabled       = true

  tags = local.common_tags
}

# # Azure AI Foundry Hub (Machine Learning Workspace)
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = local.ml_workspace_name
  resource_group_name     = azurerm_resource_group.rg_ai_project.name
  location                = azurerm_resource_group.rg_ai_project.location
  application_insights_id = azurerm_application_insights.insights.id
  key_vault_id            = azurerm_key_vault.keyvault.id
  storage_account_id      = azurerm_storage_account.storage.id
  container_registry_id   = azurerm_container_registry.acr.id

  public_network_access_enabled         = var.ml_workspace_public_access_enabled

  identity {
    type = var.ml_workspace_identity_type
  }

  tags = local.common_tags

  depends_on = [
    azurerm_application_insights.insights,
    azurerm_key_vault.keyvault,
    azurerm_storage_account.storage,
    azurerm_container_registry.acr
  ]
}
