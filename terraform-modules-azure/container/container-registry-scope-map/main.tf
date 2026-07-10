resource "azurerm_container_registry_scope_map" "acr_scope_map" {
  for_each = var.container_registry_scope_maps

  name                    = each.value.name
  container_registry_name = each.value.container_registry_name
  resource_group_name     = each.value.resource_group_name
  description             = each.value.description
  actions                 = each.value.actions
}