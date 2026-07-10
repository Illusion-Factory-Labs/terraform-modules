variable "subscription_id" {
  description = "The subscription ID where the API connections will be searched."
  type        = string
}

variable "api_connections" {
  type = map(object({
    resource_group_name = string
    api_connection_name = string
    managed_api_id      = string
    display_name        = optional(string)
  }))

  description = <<EOT
    A map of API connections to create, where the key is an identifier for the connection and the value is an object containing the following properties:
    - resource_group_name: The name of the resource group where the API connection will be created.
    - managed_api_id: The ID of the managed API to connect to (e.g., "/subscriptions/{subscriptionId}/providers/Microsoft.Web/locations/{location}/managedApis/{managedApiName}").
    - managed_api_name: The name of the managed API.
    - display_name: The display name for the API connection (optional).
  EOT

}