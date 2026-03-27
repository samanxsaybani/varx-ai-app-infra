# # # # App Service & Hosting Resources # # # #

# # Application Insights
resource "azurerm_application_insights" "insights" {
  name                = local.insights_name
  location            = azurerm_resource_group.rg_ai_project.location
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  application_type    = "web"
  retention_in_days   = 90

  tags = local.common_tags
}

# # App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.rg_ai_project.location
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  os_type             = var.app_service_os
  sku_name            = var.app_service_sku

  tags = local.common_tags
}

# # App Service
resource "azurerm_linux_web_app" "app_service" {
  name                = local.app_service_name
  location            = azurerm_resource_group.rg_ai_project.location
  resource_group_name = azurerm_resource_group.rg_ai_project.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  https_only = true

  # # Application Settings / Environment Variables
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"  = "false"
    "APPINSIGHTS_INSTRUMENTATIONKEY"       = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"

    # # Azure OpenAI Configuration
    "AZURE_OPENAI_ENDPOINT"   = azurerm_cognitive_account.openai.endpoint
    "AZURE_OPENAI_DEPLOYMENT" = "openai-deployment"
    "AZURE_OPENAI_MODEL"      = var.openai_model_version

    # # Storage Configuration
    "STORAGE_ACCOUNT_NAME" = azurerm_storage_account.storage.name

    # # Database Configuration
    "DATABASE_SERVER" = azurerm_mssql_server.sql_server.fully_qualified_domain_name
    "DATABASE_NAME"   = azurerm_mssql_database.sql_database.name

    # # Key Vault Configuration
    "KEY_VAULT_URL" = azurerm_key_vault.keyvault.vault_uri
  }

  site_config {
    minimum_tls_version         = "1.2"
    http2_enabled               = true
    remote_debugging_enabled    = false
    websockets_enabled          = true

    # # CORS Configuration (adjust for your frontend domain)
    cors {
      allowed_origins = ["*"]
      support_credentials = false
    }
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_service_plan.app_service_plan,
    azurerm_application_insights.insights
  ]

  tags = local.common_tags
}

# # Key Vault Secret - App Insights Connection String
resource "azurerm_key_vault_secret" "appinsights_connection" {
  name         = "appinsights-connection-string"
  value        = azurerm_application_insights.insights.connection_string
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_application_insights.insights
  ]
}
