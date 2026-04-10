# # # # Variable values # # # #

# # Common variables
location       = "Sweden Central"
environment    = "dev"
project_name   = "varx-ai-app"

tags = {
  "Owner"       = "Saman Saybani"
  "CostCenter"  = "Experiments"
  "Application" = "GenAI-ChatApp"
}

# # Resource Groups
ai_project_name_rg = "rg-varx-ai-project-dev"

# # Azure OpenAI Service
azure_openai_sku          = "S0"
openai_deployment_capacity = 100
openai_model_version       = "gpt-5.4-mini"

# # App Service
app_service_sku = "B2"
app_service_os  = "Linux"

# # Storage Account
storage_account_tier        = "Standard"
storage_account_replication = "GRS"

# # Database
sql_database_sku = "Basic"

# SQL Server Credentials (CHANGE THESE VALUES)
# Generate strong passwords and manage via Terraform Cloud variables or Azure Key Vault
sql_admin_username = "sqladmin"
sql_admin_password = "ChangeMe@12345"

# # Key Vault
keyvault_sku = "standard"

# # Azure AI Foundry
ml_workspace_public_access_enabled = true
ml_workspace_identity_type         = "SystemAssigned"
container_registry_sku             = "Basic"

# # Container Apps (NeuroChat)
neurochat_rg_name             = "rg-neurochat-dev"
neurochat_location            = "northeurope"
neurochat_acr_sku             = "Basic"
neurochat_model_deployment    = "gpt-4o"
neurochat_backend_cpu         = 0.5
neurochat_backend_memory      = "1Gi"
neurochat_frontend_cpu        = 0.25
neurochat_frontend_memory     = "0.5Gi"

# NeuroChat Azure AD App Registration credentials (set via environment or CI/CD secrets)
# neurochat_azure_tenant_id     = ""
# neurochat_azure_client_id     = ""
# neurochat_azure_client_secret = ""
# neurochat_openai_endpoint     = ""

# Set to frontend URL after first deploy (get from neurochat_frontend_url output)
neurochat_allowed_origins = "https://ca-neurochat-frontend-dev.icybush-25dff938.northeurope.azurecontainerapps.io"
