provider "azurerm" {
  features {}
}

locals {
  subscription_id = "15864989-4f51-4a5c-94bb-4c41ec4a7df3"
  location        = "brazilsouth"

  api_connections = {
    "api-connn-001" = {
      name                = "teams"
      resource_group_name = "rg-logic-app-example"
      managed_api_id      = "/subscriptions/${local.subscription_id}/providers/Microsoft.Web/locations/${local.location}/managedApis/teams"
      display_name        = "API Connection Example"
    }
  }

  logic_app_workflows = {
    "lapp-wf-001" = {
      name                = "lapp-wf-001"
      location            = local.location
      resource_group_name = "rg-logic-app-example"
      api_connection_id   = module.api_connection.ids["api-connn-001"]
      api_connection_name = local.api_connections["api-connn-001"].name
      managed_api_id      = local.api_connections["api-connn-001"].managed_api_id
    }
  }
}

module "api_connection" {
  source = "../../../connections/api-connection"

  subscription_id = local.subscription_id
  api_connections = local.api_connections
}

module "logic_app_workflow" {
  source = "../"

  logic_app_workflows = local.logic_app_workflows
}