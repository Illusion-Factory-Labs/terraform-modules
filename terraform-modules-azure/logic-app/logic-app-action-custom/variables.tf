variable "logic_app_actions_custom" {
  type = map(object({
    name         = string
    logic_app_id = string
    body         = string
  }))

  description = <<EOT
    A map of custom actions to create, where the key is an identifier for the action and the value is an object containing the following properties:
    - name: The name of the custom action.
    - logic_app_id: The ID of the Logic App to associate this action.
    - body: The body of the custom action as a JSON-formatted string.
  EOT
}