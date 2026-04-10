# # # #VARIABLES # # # #

# # Common variables
variable "location" {
  type        = string
  default     = "swedencentral"
  description = "Location all resources"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name (dev, staging, prod)"
}

variable "project_name" {
  type        = string
  default     = "varx-ai-app"
  description = "Project name for resource naming"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

# # Resource Groups
variable "ai_project_name_rg" {
  type        = string
  default     = "rg-varx-ai-project-dev"
  description = "Name of the Resource Group for the AI project"
}

variable "neurochat_rg_name" {
  type        = string
  default     = "rg-neurochat-dev"
  description = "Name of the Resource Group for NeuroChat Container Apps"
}

variable "neurochat_location" {
  type        = string
  default     = "northeurope"
  description = "Location for NeuroChat Container Apps resources"
}

# # Azure OpenAI Service Variables
variable "azure_openai_sku" {
  type        = string
  default     = "S0"
  description = "SKU for Azure OpenAI Service"
}

variable "openai_deployment_capacity" {
  type        = number
  default     = 100
  description = "Capacity (tokens per minute) for OpenAI deployment"
}

variable "openai_model_version" {
  type        = string
  default     = "gpt-35-turbo"
  description = "OpenAI model version to deploy (gpt-35-turbo, text-davinci-003, etc.)"
}

# # App Service Variables
variable "app_service_sku" {
  type        = string
  default     = "B2"
  description = "App Service Plan SKU"
}

variable "app_service_os" {
  type        = string
  default     = "Linux"
  description = "Operating system for App Service"
}

# # Storage Account Variables
variable "storage_account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage Account tier"
}

variable "storage_account_replication" {
  type        = string
  default     = "GRS"
  description = "Storage Account replication type"
}

# # Database Variables
variable "sql_database_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for SQL Database"
}

variable "sql_admin_username" {
  type        = string
  sensitive   = true
  description = "SQL Server administrator username"
}

variable "sql_admin_password" {
  type        = string
  sensitive   = true
  description = "SQL Server administrator password"
}

# # Key Vault Variables
variable "keyvault_sku" {
  type        = string
  default     = "standard"
  description = "Key Vault pricing tier"
}

# # Azure AI Foundry Variables
variable "ml_workspace_public_access_enabled" {
  type        = bool
  default     = true
  description = "Enable public access to ML workspace"
}

variable "ml_workspace_identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "Identity type for ML workspace (SystemAssigned or UserAssigned)"
}

variable "container_registry_sku" {
  type        = string
  default     = "Basic"
  description = "Container Registry SKU"
}

# # Container Apps Variables
variable "neurochat_acr_sku" {
  type        = string
  default     = "Basic"
  description = "SKU for the NeuroChat Container Registry"
}

variable "neurochat_azure_tenant_id" {
  type        = string
  default     = ""
  description = "Azure Tenant ID for NeuroChat backend authentication (set in Terraform Cloud)"
}

variable "neurochat_azure_client_id" {
  type        = string
  default     = ""
  description = "Azure Client ID (App Registration) for NeuroChat backend (set in Terraform Cloud)"
}

variable "neurochat_azure_client_secret" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Azure Client Secret for NeuroChat backend authentication (set in Terraform Cloud)"
}

variable "neurochat_openai_endpoint" {
  type        = string
  default     = ""
  description = "Azure OpenAI endpoint URL for NeuroChat (set in Terraform Cloud)"
}

variable "neurochat_model_deployment" {
  type        = string
  default     = "gpt-4o"
  description = "Azure OpenAI model deployment name for NeuroChat"
}

variable "neurochat_backend_cpu" {
  type        = number
  default     = 0.5
  description = "CPU allocation for NeuroChat backend container"
}

variable "neurochat_backend_memory" {
  type        = string
  default     = "1Gi"
  description = "Memory allocation for NeuroChat backend container"
}

variable "neurochat_frontend_cpu" {
  type        = number
  default     = 0.25
  description = "CPU allocation for NeuroChat frontend container"
}

variable "neurochat_frontend_memory" {
  type        = string
  default     = "0.5Gi"
  description = "Memory allocation for NeuroChat frontend container"
}

variable "neurochat_allowed_origins" {
  type        = string
  default     = "*"
  description = "CORS allowed origins for NeuroChat backend (set to frontend URL after first deploy)"
}
