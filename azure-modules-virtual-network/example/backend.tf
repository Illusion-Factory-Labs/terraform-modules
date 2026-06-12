terraform {
  backend "azurerm" {
    resource_group_name  = "rg-shared-resources"
    storage_account_name = "sasharedillfact"
    container_name       = "tfstate-examples"
    key                  = "virtual_network.tfstate"
  }
}