provider "azurerm" {
  client_id       = "3a2e94ee-c857-49a0-92cc-94ab96372235"
  client_secret   = "jDO8Q~3-1~xdW9uoogTzUEsC6EFh7SUjhb6EXb7g"
  tenant_id       = "3a7198ad-7e8e-46ec-bfff-ec7e47a94d20"
  subscription_id = "deac97e0-f6bf-4670-be7f-af2c9935ba77"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}