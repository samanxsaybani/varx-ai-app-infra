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
  default     = "gpt-4-turbo"
  description = "OpenAI model version to deploy (gpt-4-turbo, gpt-4, gpt-35-turbo, etc.)"
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
