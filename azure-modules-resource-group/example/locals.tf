locals {
  location = "brazilsouth"
  tags = {
        type = "rg"
        purpose = "exampleForTerraformModules"
      }

  resource_groups = {
    "rg1" = {
      name       = "rg-example-dev"
      location   = local.location
      managed_by = "tiagobaeta@microsoft.com"
      tags = merge(local.tags, {
        environment = "dev"
      })
    },
    "rg2" = {
      name       = "rg-example-prod"
      location   = local.location
      managed_by = "tiagobaeta@microsoft.com"
      tags = merge(local.tags, {
        environment = "prod"
      })
    }
  }
}