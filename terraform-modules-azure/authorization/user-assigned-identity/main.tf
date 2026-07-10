resource "azurerm_user_assigned_identity" "uam" {
  for_each = var.user_assigned_identities

  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  tags = each.value.tags
}
