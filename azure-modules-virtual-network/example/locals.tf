locals {
  virtual_network_id_template = "/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.Network/virtualNetworks/virtualNetworkName"
  
  subscription_id = "deac97e0-f6bf-4670-be7f-af2c9935ba77"
  location = "brazilsouth"
  tags = {
    type    = "vnet"
    purpose = "exampleForTerraformModules"
  }

  resource_groups = {
    "rg1" = {
      name = "rg-example-dev"
    },
    "rg2" = {
      name = "rg-example-prod"
    }
  }

  virtual_networks = {
    "vnet1" = {
      name                = "vnet-example-dev"
      resource_group_name = local.resource_groups["rg1"].name
      location            = local.location
      address_space       = ["10.1.0.0/16"]
      tags = merge(local.tags, {
        environment = "dev"
      })
    },
    "vnet2" = {
      name                = "vnet-example-prod"
      resource_group_name = local.resource_groups["rg2"].name
      location            = local.location
      address_space       = ["10.2.0.0/16"]
      tags = merge(local.tags, {
        environment = "prod"
      })
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

  virtual_network_peerings = {
    vnet1-to-vnet2 = {
      name                      = "vnet-dev-to-prod-peering"
      virtual_network_name      = local.virtual_networks["vnet1"].name
      remote_virtual_network_id = replace(
        replace(
          replace(
            local.virtual_network_id_template, "subscriptionId", local.subscription_id
          ), "resourceGroupName", local.resource_groups["rg2"].name
        ), "virtualNetworkName", local.virtual_networks["vnet2"].name
      )
      resource_group_name       = local.resource_groups["rg1"].name
    },
    vnet2-to-vnet1 = {
      name                      = "vnet-prod-to-dev-peering"
      virtual_network_name      = local.virtual_networks["vnet2"].name
      remote_virtual_network_id = replace(
        replace(
          replace(
            local.virtual_network_id_template, "subscriptionId", local.subscription_id
          ), "resourceGroupName", local.resource_groups["rg1"].name
        ), "virtualNetworkName", local.virtual_networks["vnet1"].name
      )
      resource_group_name       = local.resource_groups["rg2"].name
    }
  }
}