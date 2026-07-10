variable "kubernetes_cluster_node_pools" {
  type = map(object({
    name                  = string
    kubernetes_cluster_id = string
    vnet_subnet_id        = optional(string)
    vm_size               = optional(string)
    auto_scaling_enabled  = optional(bool)
    node_count            = optional(number)
    min_count             = optional(number)
    max_count             = optional(number)
    os_disk_size_gb       = optional(number)

    mode        = optional(string)
    node_labels = optional(map(string))

    upgrade_settings = optional(object({
      max_surge = string
    }))

    tags = optional(map(string))
  }))

  default = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags a serem aplicadas a todos os recursos criados por este módulo."
  default     = {}
}
