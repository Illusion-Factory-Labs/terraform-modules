output "ids" {
  description = "A map of API connection IDs, where the key is the identifier for the connection and the value is the ID of the created API connection."
  value       = { for key, conn in azurerm_api_connection.api_conn : key => conn.id }
}