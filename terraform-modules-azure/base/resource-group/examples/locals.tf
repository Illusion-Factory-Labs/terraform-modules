locals {
  resource_groups = {
    "rg1" = {
      name       = "rg1"
      location   = "brazilsouth"
      managed_by = "team1"
      tags = {
        environment = "dev"
        project     = "project1"
      }
    },
    "rg2" = {
      name       = "rg2"
      location   = "brazilsouth"
      managed_by = "team2"
      tags = {
        environment = "prod"
        project     = "project2"
      }
    }
  }
}
