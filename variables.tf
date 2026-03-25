# # # #VARIABLES # # # #

# # Common variables
variable "location" {
  type        = string
  description = "Location all resources"
}

# # Resource Groups
variable "ai_project_name_rg" {
  type        = string
  description = "Name of the Resource Group for the AI project"
}
