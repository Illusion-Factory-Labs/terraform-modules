locals {
  kubernetes_node_pools = {
    user_pool = {
      resource_group_name     = "rg-superapp-des"
      name                    = "userpool"
      kubernetes_cluster_name = "aks-superapp-des"
      vm_size                 = "Standard_DS2_v2"
      auto_scaling_enabled    = true
      node_count              = 3
      min_count               = 1
      max_count               = 5
      os_disk_size_gb         = 30
      virtual_network_name    = "vnet-superapp-des"
      subnet_name             = "snet-superapp-des"
      mode                    = "System"
      node_labels             = {}

      upgrade_settings = {
        max_surge = "1"
      }
    }
  }
}
