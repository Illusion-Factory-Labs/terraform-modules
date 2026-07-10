output "callback_urls" {
  description = "Callback URLs of the created HTTP triggers in Logic Apps"
  value       = { for k, trigger in azurerm_logic_app_trigger_http_request.trigger_http : k => trigger.callback_url }
  sensitive   = true
}