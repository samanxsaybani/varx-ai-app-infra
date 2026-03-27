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

# # OpenAI Model Deployment (GPT-3.5 Turbo)
resource "azurerm_cognitive_deployment" "openai_deployment" {
  name                 = "gpt-5.4-nano"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = var.openai_model_version
    version = "1"
  }

  sku {
    name     = "Standard"
    capacity = var.openai_deployment_capacity
  }

  depends_on = [azurerm_cognitive_account.openai]
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
