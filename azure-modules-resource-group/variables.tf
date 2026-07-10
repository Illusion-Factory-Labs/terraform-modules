variable "resource_groups" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))

  description = <<EOT
   Mapa de objetos de 'resource groups' a serem criados. Cada chave do mapa é um identificador único para o 
   'resource group' e os valores são objetos que contêm as seguintes propriedades:
   - name: O nome do 'resource group' a ser criado.
   - location: A localização geográfica onde o 'resource group' será criado.
   - managed_by: (opcional) O ID do recurso que gerencia este 'resource group'.
   - tags: (opcional) Um mapa de tags a serem associadas ao 'resource group'.
  EOT
}