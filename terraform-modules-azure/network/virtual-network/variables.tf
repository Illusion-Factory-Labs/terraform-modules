variable "virtual_networks" {
  type = map(object({
    # Campos obrigatórios
    name                = string
    resource_group_name = string
    location            = string

    # Campos mutuamente exclusivos
    address_space = optional(list(string))

    ip_address_pool = optional(list(object({
      name = string
      type = string
    })))

    # Campos opcionais
    bgp_community                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string)
    tags                           = optional(map(string))

    ddos_protection_plan = optional(object({
      id = string
    }))

    encryption = optional(object({
      enabled = bool
    }))

    subnet = optional(list(object({
      name           = string
      address_prefix = string
    })))

  }))

  description = <<EOT
    Configuração das redes virtuais. Cada chave do mapa representa o nome lógico da rede virtual, e o valor é um objeto 
    com as propriedades da rede virtual.
  EOT
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas a todos os recursos criados por este módulo."
  default     = {}
}
