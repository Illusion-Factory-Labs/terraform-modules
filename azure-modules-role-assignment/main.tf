resource "azurerm_role_assignment" "ra" {
  for_each = var.role_assignments

  name                 = each.value.name
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
  principal_id         = each.value.principal_id
}
