# # # #VARIABLES # # # #

# # Common variables
variable "location" {
  type        = string
  description = "Location all resources"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "project_name" {
  type        = string
  description = "Project name for resource naming"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

# # Resource Groups
variable "ai_project_name_rg" {
  type        = string
  description = "Name of the Resource Group for the AI project"
}

# # Azure OpenAI Service Variables
variable "azure_openai_sku" {
  type        = string
  description = "SKU for Azure OpenAI Service"
  default     = "S0"
}

variable "gpt4_deployment_capacity" {
  type        = number
  description = "Capacity (tokens per minute) for GPT-4 deployment"
  default     = 100
}

variable "gpt4_model_version" {
  type        = string
  description = "GPT-4 model version to deploy"
  default     = "gpt-4-turbo"
}

# # App Service Variables
variable "app_service_sku" {
  type        = string
  description = "App Service Plan SKU"
  default     = "B2"
}

variable "app_service_os" {
  type        = string
  description = "Operating system for App Service"
  default     = "Linux"
}

# # Storage Account Variables
variable "storage_account_tier" {
  type        = string
  description = "Storage Account tier"
  default     = "Standard"
}

variable "storage_account_replication" {
  type        = string
  description = "Storage Account replication type"
  default     = "GRS"
}

# # Database Variables
variable "sql_database_sku" {
  type        = string
  description = "SKU for SQL Database"
  default     = "Basic"
}

variable "sql_admin_username" {
  type        = string
  description = "SQL Server administrator username"
  sensitive   = true
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server administrator password"
  sensitive   = true
}

# # Key Vault Variables
variable "keyvault_sku" {
  type        = string
  description = "Key Vault pricing tier"
  default     = "standard"
}
