output "storage_account_id" {
  value = { for k, v in azurerm_storage_account.sa : k => v.id }
  description = "ID da Storage Account."
}