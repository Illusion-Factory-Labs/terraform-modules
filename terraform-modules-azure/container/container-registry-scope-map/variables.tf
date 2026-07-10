variable "container_registry_scope_maps" {
  type = map(object({
    name = string
    resource_group_name = string
    container_registry_name = string
    description = optional(string)
    actions = list(string)
  }))
  default = {}
}