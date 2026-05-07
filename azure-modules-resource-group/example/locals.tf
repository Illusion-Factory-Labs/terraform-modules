locals {
  resource_groups = {
    "rg1" = {
      name       = "rg-example-dev"
      location   = "brazilsouth"
      managed_by = "tiagobaeta@microsoft.com"
      tags = {
        environment = "dev"
        owner       = "tiagobaeta@microsoft.com"
      }
    },
    "rg2" = {
      name       = "rg-example-prod"
      location   = "brazilsouth"
      managed_by = "tiagobaeta@microsoft.com"
      tags = {
        environment = "prod"
        owner       = "tiagobaeta@microsoft.com"
      }
    }
  }
}