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

  virtual_networks = {
    "vnet1" = {
      name                = "vnet-example-dev"
      resource_group_name = local.resource_groups["rg1"].name
      location            = local.resource_groups["rg1"].location
      address_space       = ["10.1.0.0/16"]
      tags = {
        environment = "dev"
        owner       = "tiagobaeta@microsoft.com"
      }
    },
    "vnet2" = {
      name                = "vnet-example-prod"
      resource_group_name = local.resource_groups["rg2"].name
      location            = local.resource_groups["rg2"].location
      address_space       = ["10.2.0.0/16"]
      tags = {
        environment = "prod"
        owner       = "tiagobaeta@microsoft.com"
      }
    }
  }

  subnets = {
    "snet1" = {
      name                 = "snet-example-dev"
      resource_group_name  = local.resource_groups["rg1"].name
      virtual_network_name = local.virtual_networks["vnet1"].name
      address_prefixes     = ["10.1.0.0/24"]
    }
    "snet2" = {
      name                 = "snet-example-prod"
      resource_group_name  = local.resource_groups["rg2"].name
      virtual_network_name = local.virtual_networks["vnet2"].name
      address_prefixes     = ["10.2.0.0/24"]
    }
  }
}