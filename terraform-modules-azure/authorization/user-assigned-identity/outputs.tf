output "id" {
  value = { for k, v in azurerm_user_assigned_identity.uam : k => v.id }
}

output "principal_id" {
  value = { for k, v in azurerm_user_assigned_identity.uam : k => v.principal_id }
}
