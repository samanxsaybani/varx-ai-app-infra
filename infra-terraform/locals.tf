# # # # Local Values # # # #

locals {
  # # Compute resource naming conventions
  resource_prefix = "${var.project_name}-${var.environment}"

  # # Azure OpenAI Service
  azure_openai_name = "aoai-${local.resource_prefix}"

  # # App Service
  app_service_plan_name = "asp-${local.resource_prefix}"
  app_service_name      = "app-${local.resource_prefix}"

  # # Storage Account (must be lowercase, no hyphens)
  storage_account_name = replace("st${var.project_name}${var.environment}", "-", "")

  # # Database
  sql_server_name          = "sql-${local.resource_prefix}"
  sql_database_name        = "db-${local.resource_prefix}"
  sql_firewall_rule_name   = "AllowAzureServices"

  # # Key Vault (must be unique globally)
  keyvault_name = "kv-${local.resource_prefix}-${random_string.unique_suffix.result}"

  # # Application Insights
  insights_name = "appi-${local.resource_prefix}"

  # # Common tags
  common_tags = merge(
    var.tags,
    {
      "Environment" = var.environment
      "Project"     = var.project_name
      "Terraform"   = "true"
      "CreatedDate" = timestamp()
    }
  )
}

# # Generate unique suffix for globally unique resources
resource "random_string" "unique_suffix" {
  length  = 8
  special = false
  lower   = true
}
