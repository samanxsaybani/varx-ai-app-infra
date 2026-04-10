# # # # NeuroChat Container Apps # # # #

# # Container Registry for NeuroChat images
resource "azurerm_container_registry" "neurochat_acr" {
  name                = local.neurochat_acr_name
  resource_group_name = azurerm_resource_group.rg_neurochat.name
  location            = azurerm_resource_group.rg_neurochat.location
  sku                 = var.neurochat_acr_sku
  admin_enabled       = true

  tags = local.common_tags
}

# # Log Analytics Workspace (required by Container Apps Environment)
resource "azurerm_log_analytics_workspace" "neurochat_logs" {
  name                = "log-neurochat-${var.environment}"
  resource_group_name = azurerm_resource_group.rg_neurochat.name
  location            = azurerm_resource_group.rg_neurochat.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.common_tags
}

# # Container Apps Environment
resource "azurerm_container_app_environment" "neurochat_env" {
  name                       = local.container_apps_env_name
  resource_group_name        = azurerm_resource_group.rg_neurochat.name
  location                   = azurerm_resource_group.rg_neurochat.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.neurochat_logs.id

  # # Consumption-only workload profile avoids the free-tier cluster capacity limits
  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    minimum_count         = 0
    maximum_count         = 0
  }

  tags = local.common_tags

  depends_on = [azurerm_log_analytics_workspace.neurochat_logs]
}

# # NeuroChat Backend Container App
resource "azurerm_container_app" "neurochat_backend" {
  name                         = local.container_app_backend_name
  resource_group_name          = azurerm_resource_group.rg_neurochat.name
  container_app_environment_id = azurerm_container_app_environment.neurochat_env.id
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  registry {
    server               = azurerm_container_registry.neurochat_acr.login_server
    username             = azurerm_container_registry.neurochat_acr.admin_username
    password_secret_name = "acr-password"
  }

  secret {
    name  = "acr-password"
    value = azurerm_container_registry.neurochat_acr.admin_password
  }

  secret {
    name  = "azure-client-secret"
    value = var.neurochat_azure_client_secret
  }

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "neurochat-backend"
      image  = "${azurerm_container_registry.neurochat_acr.login_server}/neurochat-backend:latest"
      cpu    = var.neurochat_backend_cpu
      memory = var.neurochat_backend_memory

      env {
        name  = "AZURE_TENANT_ID"
        value = var.neurochat_azure_tenant_id
      }

      env {
        name  = "AZURE_CLIENT_ID"
        value = var.neurochat_azure_client_id
      }

      env {
        name        = "AZURE_CLIENT_SECRET"
        secret_name = "azure-client-secret"
      }

      env {
        name  = "AZURE_OPENAI_ENDPOINT"
        value = var.neurochat_openai_endpoint
      }

      env {
        name  = "MODEL_DEPLOYMENT"
        value = var.neurochat_model_deployment
      }

      env {
        name  = "ALLOWED_ORIGINS"
        value = var.neurochat_allowed_origins
      }
    }
  }

  ingress {
    external_enabled = false
    target_port      = 8000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = local.common_tags

  depends_on = [
    azurerm_container_app_environment.neurochat_env,
    azurerm_container_registry.neurochat_acr
  ]
}

# # NeuroChat Frontend Container App
resource "azurerm_container_app" "neurochat_frontend" {
  name                         = local.container_app_frontend_name
  resource_group_name          = azurerm_resource_group.rg_neurochat.name
  container_app_environment_id = azurerm_container_app_environment.neurochat_env.id
  revision_mode                = "Single"
  workload_profile_name        = "Consumption"

  registry {
    server               = azurerm_container_registry.neurochat_acr.login_server
    username             = azurerm_container_registry.neurochat_acr.admin_username
    password_secret_name = "acr-password"
  }

  secret {
    name  = "acr-password"
    value = azurerm_container_registry.neurochat_acr.admin_password
  }

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "neurochat-frontend"
      image  = "${azurerm_container_registry.neurochat_acr.login_server}/neurochat-frontend:latest"
      cpu    = var.neurochat_frontend_cpu
      memory = var.neurochat_frontend_memory
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = local.common_tags

  depends_on = [
    azurerm_container_app_environment.neurochat_env,
    azurerm_container_registry.neurochat_acr,
    azurerm_container_app.neurochat_backend
  ]
}
