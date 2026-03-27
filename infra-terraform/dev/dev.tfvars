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
openai_model_version       = "gpt-35-turbo"

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
