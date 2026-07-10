resource "azurerm_private_dns_zone" "pdns_zone" {
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  
  dynamic "soa_record" {
    for_each = each.value.soa_record != null ? [each.value.soa_record] : []
    
    content {
      email = each.value.soa_record.email
      expire_time  = each.value.soa_record.expire_time
      minimum_ttl  = each.value.soa_record.minimum_ttl
      refresh_time = each.value.soa_record.refresh_time
      retry_time   = each.value.soa_record.retry_time
      ttl          = each.value.soa_record.ttl

      tags = each.value.soa_record.tags
    }
  }

  tags = each.value.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdns_vnet_link" {
  for_each = var.private_dns_zone_virtual_network_links

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  resolution_policy     = each.value.resolution_policy

  tags = each.value.tags

  depends_on = [ azurerm_private_dns_zone.pdns_zone ]
}