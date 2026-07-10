variable "resource_groups" {
  type = map(object({
    name     = string
    location = string

    managed_by = optional(string)
    tags       = optional(map(string))
  }))

  description = <<EOT
    Dicionário contendo um ou mais 'resource group'. Cada chave do dicionário contém um objeto com as propriedades do 
    'resource group'
  EOT
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas a todos os recursos criados por este módulo."
  default     = {}
}
