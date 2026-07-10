variable "private_dns_zones" {
  type = map(object({
    name                = string
    resource_group_name = string

    soa_record = optional(object({
      email        = string
      expire_time  = optional(number)
      minimum_ttl  = optional(number)
      refresh_time = optional(number)
      retry_time   = optional(number)
      ttl          = optional(number)
      tags         = optional(map(string))
    }))

    tags = optional(map(string))
  }))
}