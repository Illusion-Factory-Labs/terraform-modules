variable "virtual_network_peerings" {
  type = map(object({
    # Required
    name                      = string
    virtual_network_name      = string
    remote_virtual_network_id = string
    resource_group_name       = string

    # Optional
    allow_virtual_network_access           = optional(bool, true)
    allow_forwarded_traffic                = optional(bool, false)
    allow_gateway_transit                  = optional(bool, false)
    local_subnet_names                     = optional(list(string))
    only_ipv6_peering_enabled              = optional(bool)
    peer_complete_virtual_networks_enabled = optional(bool, true)
    remote_subnet_names                    = optional(list(string))
    use_remote_gateways                    = optional(bool, false)
    
    triggers                               = optional(map(string))
  }))

  default = {}
}