resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.azure_kubernetes_clusters

  name                                = each.value.name
  location                            = each.value.location
  resource_group_name                 = each.value.resource_group_name
  dns_prefix                          = each.value.dns_prefix
  dns_prefix_private_cluster          = each.value.dns_prefix_private_cluster
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false

  private_dns_zone_id = each.value.private_dns_zone_id

  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool != null ? [each.value.default_node_pool] : []

    content {
      name       = default_node_pool.value.name
      node_count = default_node_pool.value.node_count
      vm_size    = default_node_pool.value.vm_size

      vnet_subnet_id = default_node_pool.value.vnet_subnet_id

      dynamic "upgrade_settings" {
        for_each = default_node_pool.value.upgrade_settings != null ? [default_node_pool.value.upgrade_settings] : []

        content {
          max_surge = upgrade_settings.value.max_surge
        }
      }
    }
  }

  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }

  network_profile {
    network_plugin      = each.value.network_profile.network_plugin
    network_policy      = each.value.network_profile.network_policy
    network_plugin_mode = each.value.network_profile.network_plugin_mode
  }

  tags = each.value.tags
}
