resource "azurerm_private_endpoint" "pe" {
  for_each = var.private_endpoints

    name = each.value.name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    subnet_id = each.value.subnet_id

    dynamic "private_service_connection" {
      for_each = each.value.private_service_connection != null ? [each.value.private_service_connection] : []
      content {
        name                           = private_service_connection.value.name
        private_connection_resource_id = private_service_connection.value.private_connection_resource_id
        is_manual_connection           = private_service_connection.value.is_manual_connection
        subresource_names              = private_service_connection.value.subresource_names
      }
    }

    dynamic "private_dns_zone_group" {
      for_each = each.value.private_dns_zone_group != null ? [each.value.private_dns_zone_group] : []
      content {
        name                 = private_dns_zone_group.value.name
        private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
      }
    }

    tags = each.value.tags
}