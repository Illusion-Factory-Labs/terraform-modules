variable "container_registries" {
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    sku = string

    admin_enabled = optional(bool)
    public_network_access_enabled = optional(bool)
    zone_redundancy_enabled = optional(bool)
    anonymous_pull_enabled = optional(bool)
    data_endpoint_enabled = optional(bool)
    network_rule_bypass_option = optional(string)
    quarantine_policy_enabled = optional(bool)
    trust_policy_enabled = optional(bool)
    export_policy_enabled = optional(bool)

    tags = optional(map(string))
  }))
}