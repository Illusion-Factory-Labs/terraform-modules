terraform {
  backend "azurerm" {
    resource_group_name  = "rg-shared-resources"
    storage_account_name = "sasharedrestbaeta"
    container_name       = "tfstate"
    key                  = "hslab.dev.tfstate"
    use_azuread_auth     = true
  }
}