resource "azurerm_monitor_diagnostic_setting" "mds" {
  for_each = var.monitor_diagnostic_settings

  name                       = each.value.name
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  dynamic "enabled_metric" {
    for_each = lookup(each.value, "enabled_metrics", [])
    
    content {
      category = enabled_metric.value.category
    }
  }

  dynamic "enabled_log" {
    for_each = lookup(each.value, "enabled_logs", [])
    
    content {
      category = enabled_log.value.category
    }
  }
}