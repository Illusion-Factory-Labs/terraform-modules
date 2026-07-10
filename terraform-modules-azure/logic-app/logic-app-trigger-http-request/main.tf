resource "azurerm_logic_app_trigger_http_request" "trigger_http" {
  for_each = var.logic_app_trigger_http_requests

  name         = each.value.name
  logic_app_id = each.value.logic_app_id
  method       = each.value.method != null ? each.value.method : "POST"
  schema       = file(each.value.json_schema_file_path)
}