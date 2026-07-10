resource "azurerm_logic_app_action_custom" "action_custom" {
  for_each = var.logic_app_actions_custom

  name         = each.value.name
  logic_app_id = each.value.logic_app_id
  body         = each.value.body

}