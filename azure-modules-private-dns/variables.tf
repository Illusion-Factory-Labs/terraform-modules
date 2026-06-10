variable "private_dns_zones" {
  type = map(object({
    # Required
    name                = string
    resource_group_name = string

    # Optional
    soa_record = optional(object({
      email = string

      expire_time  = optional(number)
      minimum_ttl  = optional(number)
      refresh_time = optional(number)
      retry_time   = optional(number)
      ttl          = optional(number)

      tags = optional(map(string))
    }))

    tags = optional(map(string))
  }))
  default = {}
}

variable "private_dns_zone_virtual_network_links" {
  type = map(object({
    # Required
    name                = string
    resource_group_name = string
    private_dns_zone_name = string
    virtual_network_id    = string

    # Optional
    registration_enabled = optional(bool)
    resolution_policy     = optional(string)
    tags = optional(map(string))
  }))

  default = {}
}