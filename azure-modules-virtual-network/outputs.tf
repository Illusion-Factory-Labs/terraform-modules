output "virtual_network_id" {
  value = {
    for k, v in azurerm_virtual_network.vnet : k => v.id
  }
}