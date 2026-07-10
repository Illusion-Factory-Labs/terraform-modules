resource "azurerm_api_connection" "api_conn" {
  for_each = var.api_connections

  name                = each.value.api_connection_name
  resource_group_name = each.value.resource_group_name
  managed_api_id      = each.value.managed_api_id
  display_name        = each.value.display_name

  # parameter_values vary by connector/auth type; for OAuth connectors this often isn't enough
  # and the portal authorization step is still required.
}