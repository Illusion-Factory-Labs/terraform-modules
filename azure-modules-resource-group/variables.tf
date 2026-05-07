variable "resource_groups" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))

  description = <<EOT
    Map of resource group objects to be created. For details please refer to the documentation on 
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group.
  EOT
}