resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_networks != null ? var.virtual_networks : {}

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  address_space = each.value.address_space

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? [each.value.ip_address_pool] : []

    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  bgp_community = each.value.bgp_community

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan_id != null ? [each.value.ddos_protection_plan_id] : []

    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enabled
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []

    content {
      enforcement = encryption.value.enforcement
    }
  }

  dns_servers                    = each.value.dns_servers
  edge_zone                      = each.value.edge_zone
  flow_timeout_in_minutes        = each.value.flow_timeout_in_minutes
  private_endpoint_vnet_policies = each.value.private_endpoint_vnet_policies

  tags = each.value.tags
}

resource "azurerm_subnet" "snet" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

  # Mutually exclusives
  address_prefixes = each.value.address_prefixes

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? [each.value.ip_address_pool] : []

    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  dynamic "delegation" {
    for_each = each.value.delegations != null ? each.value.delegations : []

    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  default_outbound_access_enabled               = each.value.default_outbound_access_enabled
  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  sharing_scope                                 = each.value.sharing_scope
  service_endpoints                             = each.value.service_endpoints
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids

  depends_on = [azurerm_virtual_network.vnet]
}

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

    depends_on = [ azurerm_subnet.snet ]
}