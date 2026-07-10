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

  logic_app_trigger_http_requests = {
    "http-trigger-001" = {
      name                  = "http-trigger-teams"
      logic_app_id          = module.logic_app_workflow.ids["lapp-wf-001"]
      method                = "POST"
      json_schema_file_path = "../../../../schemas/trigger_http_request.json"
    }

  }
}

module "api_connection" {
  source = "../../../connections/api-connection"

  subscription_id = local.subscription_id
  api_connections = local.api_connections
}

module "logic_app_workflow" {
  source = "../../../logic-app/logic-app-workflow"

  logic_app_workflows = local.logic_app_workflows

  depends_on = [module.api_connection]
}

module "logic_app_trigger_http_request" {
  source = "../"

  logic_app_trigger_http_requests = local.logic_app_trigger_http_requests

  depends_on = [module.logic_app_workflow]
}