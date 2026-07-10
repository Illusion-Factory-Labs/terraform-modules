variable "logic_app_workflows" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    connections = optional(map(object({
      api_connection_name = string
      api_connection_id   = string
      managed_api_id      = string
    })), null)
  }))
}