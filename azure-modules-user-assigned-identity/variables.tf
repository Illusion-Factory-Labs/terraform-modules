variable "user_assigned_identities" {
  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
    isolation_scope     = optional(string, "Regional")

    tags = optional(map(string))

  }))

  description = <<EOT
    Dicionário contendo uma ou mais identidades gerenciadas atribuídas pelo usuário. Cada chave do dicionário contém um 
    objeto com as propriedades da identidade.
  EOT

  validation {
    condition     = alltrue([for identity in values(var.user_assigned_identities) : identity.isolation_scope == "Regional" || identity.isolation_scope == "Global"])
    error_message = "O único valor possível para a propriedade 'isolation_scope' é 'Regional'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas a todos os recursos criados por este módulo."
  default     = {}
}
