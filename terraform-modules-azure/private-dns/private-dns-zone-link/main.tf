resource "azurerm_private_dns_zone_virtual_network_link" "pdns_zone_vnet_link" {
  for_each = var.private_dns_zone_virtual_network_links

  name                  = each.value.name
  private_dns_zone_name = each.value.private_dns_zone_name
  resource_group_name   = each.value.resource_group_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
  resolution_policy     = each.value.resolution_policy

  tags = each.value.tags
}