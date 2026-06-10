variable "role_assignments" {
  type = map(object({
    name                 = optional(string)
    role_definition_name = string
    scope                = string
    principal_id         = string
  }))
}
