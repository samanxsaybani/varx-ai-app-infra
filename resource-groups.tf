# # # # Resource Groups # # # #

# AI Project RG
resource "azurerm_resource_group" "rg_ai_project" {
  name     = var.ai_project_name_rg
  location = var.location
}