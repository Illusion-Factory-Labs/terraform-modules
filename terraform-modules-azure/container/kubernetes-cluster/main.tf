resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.azure_kubernetes_clusters

  name                                = each.value.name
  location                            = each.value.location
  resource_group_name                 = each.value.resource_group_name
  dns_prefix                          = each.value.dns_prefix
  dns_prefix_private_cluster          = each.value.dns_prefix_private_cluster
  private_cluster_enabled             = each.value.private_cluster_enabled
  private_cluster_public_fqdn_enabled = each.value.private_cluster_public_fqdn_enabled
  sku_tier                            = each.value.sku_tier
  private_dns_zone_id                 = each.value.private_dns_zone_id
  automatic_upgrade_channel           = each.value.automatic_upgrade_channel
  workload_identity_enabled             = each.value.workload_identity_enabled
  oidc_issuer_enabled       = each.value.oidc_issuer_enabled

  dynamic "default_node_pool" {
    for_each = each.value.default_node_pool != null ? [each.value.default_node_pool] : []

    content {
      name                 = default_node_pool.value.name
      node_count           = default_node_pool.value.node_count
      vm_size              = default_node_pool.value.vm_size
      auto_scaling_enabled = default_node_pool.value.auto_scaling_enabled
      vnet_subnet_id       = default_node_pool.value.vnet_subnet_id
      min_count            = default_node_pool.value.min_count
      max_count            = default_node_pool.value.max_count
      os_disk_size_gb      = default_node_pool.value.os_disk_size_gb

      dynamic "upgrade_settings" {
        for_each = default_node_pool.value.upgrade_settings != null ? [default_node_pool.value.upgrade_settings] : []

        content {
          max_surge = upgrade_settings.value.max_surge
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? [each.value.maintenance_window] : []
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed != null ? [maintenance_window.value.allowed] : []
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed != null ? [maintenance_window.value.not_allowed] : []
        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = each.value.maintenance_window_auto_upgrade != null ? [each.value.maintenance_window_auto_upgrade] : []

    content {
      frequency    = maintenance_window_auto_upgrade.value.frequency
      interval     = maintenance_window_auto_upgrade.value.interval
      duration     = maintenance_window_auto_upgrade.value.duration
      day_of_week  = maintenance_window_auto_upgrade.value.day_of_week
      day_of_month = maintenance_window_auto_upgrade.value.day_of_month
      week_index   = maintenance_window_auto_upgrade.value.week_index
      start_time   = maintenance_window_auto_upgrade.value.start_time
      utc_offset   = maintenance_window_auto_upgrade.value.utc_offset
      start_date   = maintenance_window_auto_upgrade.value.start_date

      dynamic "not_allowed" {
        for_each = maintenance_window_auto_upgrade.value.not_allowed != null ? [maintenance_window_auto_upgrade.value.not_allowed] : []
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
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
    dns_service_ip      = each.value.network_profile.dns_service_ip
    service_cidr        = each.value.network_profile.service_cidr
    service_cidrs       = each.value.network_profile.service_cidrs
    pod_cidr            = each.value.network_profile.pod_cidr
    pod_cidrs           = each.value.network_profile.pod_cidrs
    outbound_type       = each.value.network_profile.outbound_type
    load_balancer_sku   = each.value.network_profile.load_balancer_sku
    network_data_plane  = each.value.network_profile.network_data_plane
    network_mode        = each.value.network_profile.network_mode
    ip_versions         = each.value.network_profile.ip_versions
  }

  tags = each.value.tags
}
