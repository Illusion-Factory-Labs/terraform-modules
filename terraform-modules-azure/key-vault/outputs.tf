output "key_vault_id" {
  value = { for k, v in azurerm_key_vault.kv : k => v.id }
  description = "ID da Key Vault."
}

output "key_vault_uri" {
  value = { for k, v in azurerm_key_vault.kv : k => v.vault_uri }
  description = "URI da Key Vault."
}