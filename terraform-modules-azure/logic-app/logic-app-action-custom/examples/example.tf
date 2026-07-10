provider "azurerm" {
  features {}
}

provider "random" {}

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
      json_schema_file_path = "./templates/trigger_http_request.json"
    }
  }

  logic_app_actions_custom = {
    "action-custom-001" = {
      name         = "check-secret-condition"
      logic_app_id = module.logic_app_workflow.ids["lapp-wf-001"]
      body = templatefile("terraform-logic-app-teams", {
        callback_url_secret = random_password.logicapp_header_secret.result
      })
    },
    "action-custom-002" = {
      name         = "send-teams-message"
      logic_app_id = module.logic_app_workflow.ids["lapp-wf-001"]

      body = templatefile("../../../../templates/send_teams_message.json.tftpl", {
        run_after_action_name = "ResponseSuccess"
      })
    }
  }
}

resource "random_password" "logicapp_header_secret" {
  length  = 64
  special = true

  # Optional: restrict special chars to avoid issues in headers/tools
  override_special = "-_@#%+="
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
  source = "../../../logic-app/logic-app-trigger-http-request"

  logic_app_trigger_http_requests = local.logic_app_trigger_http_requests

  depends_on = [module.logic_app_workflow]
}

module "logic_app_actions_custom" {
  source = "../"

  logic_app_actions_custom = local.logic_app_actions_custom

  depends_on = [module.logic_app_trigger_http_request]
}