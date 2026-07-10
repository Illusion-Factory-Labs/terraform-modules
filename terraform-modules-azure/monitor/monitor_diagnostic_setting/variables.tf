variable "monitor_diagnostic_settings" {
  type = map(object({
    name = string
    target_resource_id = string
    log_analytics_workspace_id = optional(string, null)

    enabled_metrics = optional(list(object({
      category = string
    })), [])

    enabled_logs = optional(list(object({
      category = string
    })), [])


  }))
}