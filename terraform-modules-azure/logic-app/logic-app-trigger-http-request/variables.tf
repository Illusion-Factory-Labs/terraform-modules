variable "logic_app_trigger_http_requests" {
  type = map(object({
    name         = string
    logic_app_id = string
    method       = optional(string)

    json_schema_file_path = string
  }))

  description = <<EOT
    A map of Logic App HTTP trigger requests to create, where the key is an identifier for the trigger and the value is an object containing the following properties:
    - name: The name of the HTTP trigger request.
    - logic_app_id: The ID of the Logic App workflow to which the trigger will be added.
    - method: The HTTP method for the trigger (e.g., "GET", "POST", etc.). Optional, defaults to "POST".
    - json_schema_file_path: path to the JSON file containing the schema for the HTTP request body.
  EOT
}