output "ids" {
  description = "IDs of the created Logic App Workflows"
  value       = { for key, wf in azurerm_logic_app_workflow.lapp-wf : key => wf.id }
}