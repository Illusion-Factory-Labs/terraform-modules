variable "virtual_networks" {
  type = map(object({
    # Required
    name                = string
    resource_group_name = string
    location            = string

    # Mutually exclusives
    address_space = optional(list(string))

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))

    # Optional
    bgp_community = optional(string)

    ddos_protection_plan_id = optional(object({
      id     = string
      enable = bool
    }))

    encryption = optional(object({
      enforcement = string
    }), {enforcement = "AllowUnencrypted"})

    dns_servers                    = optional(list(string), [])
    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string, "Disabled")

    tags = optional(map(string))

  }))

  validation {
    condition = alltrue([
      for vnet in var.virtual_networks : (
        (length(vnet.address_space) > 0 && vnet.ip_address_pool == null) ||
        (length(vnet.address_space) == 0 && vnet.ip_address_pool != null)
      )
    ])
    error_message = "Either 'address_space' or 'ip_address_pool' must be specified but not both."
  }

  validation {
    condition = alltrue([
      for vnet in var.virtual_networks : (
        vnet.encryption.enforcement == "DropUnencrypted" ||
        vnet.encryption.enforcement == "AllowUnencrypted"
      )
    ])
    error_message = "Only allowed values for 'enforcement' in a 'encryption' block are 'DropUnencrypted' and 'AllowUnencrypted'."
  }

  validation {
    condition = alltrue([
      for vnet in var.virtual_networks : (
        vnet.private_endpoint_vnet_policies == "Basic" ||
        vnet.private_endpoint_vnet_policies == "Disabled"
      )
    ])
    error_message = "Only allowed values for 'private_endpoint_vnet_policies' are 'Basic' and 'Disabled'."
  }
}

variable "subnets" {
  type = map(object({
    # Required
    name                 = string
    resource_group_name  = string
    virtual_network_name = string

    # Mutually exclusives
    address_prefixes = optional(list(string))

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))

    # Optional
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })))

    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
  }))

  validation {
    condition = alltrue([
      for vnet in var.subnets : (
        (length(vnet.address_prefixes) > 0 && vnet.ip_address_pool == null) ||
        (length(vnet.address_prefixes) == 0 && vnet.ip_address_pool != null)
      )
    ])
    error_message = "Either 'address_prefixes' or 'ip_address_pool' must be specified but not both."
  }
}