resource "azurerm_logic_app_workflow" "lapp-wf" {
  for_each = var.logic_app_workflows

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  workflow_parameters = {
    "$connections" = jsonencode({
      type         = "Object"
      defaultValue = {}
    })
  }

  parameters = {
    "$connections" = each.value.connections != null ? jsonencode({
      for connection_key, connection_value in each.value.connections : connection_key => {
        connectionId   = connection_value.api_connection_id
        connectionName = connection_value.api_connection_name
        id             = connection_value.managed_api_id
      }
    }) : jsonencode({})
  }
}