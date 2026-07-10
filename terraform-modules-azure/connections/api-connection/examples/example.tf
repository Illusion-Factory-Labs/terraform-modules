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
}

module "api_connection" {
  source = "../"

  subscription_id = local.subscription_id
  api_connections = local.api_connections
}