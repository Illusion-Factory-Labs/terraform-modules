resource "azurerm_virtual_network_peering" "vnet_peering" {
    for_each = var.virtual_network_peerings

    name                      = each.value.name
    virtual_network_name      = each.value.virtual_network_name
    remote_virtual_network_id = each.value.remote_virtual_network_id
    resource_group_name       = each.value.resource_group_name

    # Optional
    allow_virtual_network_access           = each.value.allow_virtual_network_access
    allow_forwarded_traffic                = each.value.allow_forwarded_traffic
    allow_gateway_transit                  = each.value.allow_gateway_transit
    local_subnet_names                     = each.value.local_subnet_names
    only_ipv6_peering_enabled              = each.value.only_ipv6_peering_enabled
    peer_complete_virtual_networks_enabled = each.value.peer_complete_virtual_networks_enabled
    remote_subnet_names                    = each.value.remote_subnet_names
    use_remote_gateways                    = each.value.use_remote_gateways
    triggers                               = each.value.triggers
}