resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_node_pool" {
  for_each = var.kubernetes_cluster_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = each.value.kubernetes_cluster_id
  vnet_subnet_id        = each.value.vnet_subnet_id
  vm_size               = each.value.vm_size
  auto_scaling_enabled  = each.value.auto_scaling_enabled
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_disk_size_gb       = each.value.os_disk_size_gb

  mode        = each.value.mode
  node_labels = each.value.node_labels

  upgrade_settings {
    max_surge = each.value.upgrade_settings.max_surge
  }

  tags = each.value.tags
}
