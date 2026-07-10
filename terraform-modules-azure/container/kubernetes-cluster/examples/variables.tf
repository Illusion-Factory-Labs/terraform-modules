variable "location" {
  type        = string
  description = "Região do Azure onde os recursos serão provisionados."
}

variable "environment" {
  type        = string
  default     = "desenvolvimento"
  description = "Ambiente de implantação (ex: desenvolvimento, homologação, produção)."
}

variable "app_name" {
  type        = string
  default     = "superapp"
  description = "Nome da aplicação para compor os nomes dos recursos."
}

variable "resource_group" {
  type = object({
    use_existing = bool
    name         = string
  })
  description = <<EOT
    Indica se deve usar um grupo de recursos existente. Se 'true', deve-se fornecer o nome do grupo de recursos existente.
  EOT
}

variable "subnet" {
  type = object({
    use_existing         = bool
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
  })
  description = <<EOT
    Indica se deve usar uma sub-rede existente. Se 'true', deve-se fornecer o nome da sub-rede existente.
  EOT
}

variable "use_existing_user_assigned_identity" {
  type        = bool
  description = "Indica se o cluster AKS deve usar uma identidade existente gerenciada atribuída pelo usuário."
}

variable "kubernetes_version" {
  type        = string
  default     = "1.34.6"
  description = "Versão do Kubernetes para o cluster AKS."
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  default     = "rg-superapp-des"
  description = "Nome do grupo de recursos onde a zona DNS privada está localizada."
}

variable "private_dns_zone_name" {
  type        = string
  default     = "aks-superapp-des-001.privatelink.brazilsouth.azmk8s.io"
  description = "Nome da zona DNS privada."
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "development"
    Project     = "terraform-aks"
    ManagedBy   = "terraform"
    CreatedDate = ""
  }
  description = "Tags a serem aplicadas aos recursos do cluster AKS."
}
