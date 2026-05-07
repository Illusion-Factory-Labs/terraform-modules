output "id" {
  description = "Id of the resource group."
  value = {
    for k, v in azurerm_resource_group.rg : k => v.id
  }
}