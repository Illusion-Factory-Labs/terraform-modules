variable "private_dns_zone_virtual_network_links" {
  type = map(object({
    name                  = string
    private_dns_zone_name = string
    resource_group_name   = string
    virtual_network_id    = string
    registration_enabled  = optional(bool)
    resolution_policy     = optional(string)

    tags = optional(map(string))
  }))
}