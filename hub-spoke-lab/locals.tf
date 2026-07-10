locals {
  resource_group_template_id  = "/subscriptions/${var.subscription_id}/resourceGroups/resourceGroupName"
  virtual_network_template_id = "${local.resource_group_template_id}/providers/Microsoft.Network/virtualNetworks/virtualNetworkName"
  subnet_template_id          = "${local.virtual_network_template_id}/subnets/subnetName"

  environment = var.environment
  location    = var.location
  app_name    = "hslab"
  suffix      = "${local.app_name}-${local.environment}"

  resource_group_hub_name  = "rg-hub-${local.suffix}-001"
  virtual_network_hub_name = "vnet-hub-${local.suffix}-001"
  subnet_hub_shared_name   = "snet-hub-shared-${local.suffix}-001"

  resource_group_spoke_aks_name  = "rg-spoke-aks-${local.suffix}-001"
  virtual_network_spoke_aks_name = "vnet-spoke-aks-${local.suffix}-001"
  subnet_spoke_aks_name          = "snet-spoke-aks-${local.suffix}-001"

  resource_group_spoke_data_name  = "rg-spoke-data-${local.suffix}-001"
  virtual_network_spoke_data_name = "vnet-spoke-data-${local.suffix}-001"
  subnet_spoke_data_name          = "snet-spoke-data-${local.suffix}-001"

  aks_identity_name = "identity-aks-${local.suffix}-001"
  aks_cluster_name = "aks-${local.suffix}-001"

  resource_groups = {
    rg_hub = {
      name       = local.resource_group_hub_name
      location   = local.location
      managed_by = "Terraform"
      tags = merge(var.tags, {
        type      = "resourceGroup"
        
      })
    }
    rg_spoke_aks = {
      name       = local.resource_group_spoke_aks_name
      location   = local.location
      managed_by = "Terraform"
      tags = merge(var.tags, {
        type      = "resourceGroup"
        
      })
    }
    rg_spoke_data = {
      name       = local.resource_group_spoke_data_name
      location   = local.location
      managed_by = "Terraform"
      tags = merge(var.tags, {
        type      = "resourceGroup"
        
      })
    }
  }

  virtual_networks = {
    vnet_hub = {
      name                = local.virtual_network_hub_name
      resource_group_name = local.resource_group_hub_name
      location            = local.location
      address_space       = ["10.0.0.0/16"]
      tags = merge(var.tags, {
        type      = "virtualNetwork"
        
      })
    }
    vnet_spoke_aks = {
      name                = local.virtual_network_spoke_aks_name
      resource_group_name = local.resource_group_spoke_aks_name
      location            = local.location
      address_space       = ["10.1.0.0/16"]
      tags = merge(var.tags, {
        type      = "virtualNetwork"
        
      })
    }
    vnet_spoke_data = {
      name                = local.virtual_network_spoke_data_name
      resource_group_name = local.resource_group_spoke_data_name
      location            = local.location
      address_space       = ["10.2.0.0/16"]
      tags = merge(var.tags, {
        type      = "virtualNetwork"
        
      })
    }
  }

  subnets = {
    snet_hub = {
      name                 = local.subnet_hub_shared_name
      resource_group_name  = local.resource_group_hub_name
      virtual_network_name = local.virtual_network_hub_name
      address_prefixes     = ["10.0.1.0/24"]
    }
    snet_spoke_aks = {
      name                 = local.subnet_spoke_aks_name
      resource_group_name  = local.resource_group_spoke_aks_name
      virtual_network_name = local.virtual_network_spoke_aks_name
      address_prefixes     = ["10.1.1.0/24"]
    }
    snet_spoke_data = {
      name                 = local.subnet_spoke_data_name
      resource_group_name  = local.resource_group_spoke_data_name
      virtual_network_name = local.virtual_network_spoke_data_name
      address_prefixes     = ["10.2.1.0/24"]
    }
  }

  virtual_network_peerings = {
    peering_hub_to_spoke_aks = {
      name                         = "peering-hub-to-spoke-aks-${local.suffix}-001"
      resource_group_name          = local.resource_group_hub_name
      virtual_network_name         = local.virtual_network_hub_name
      remote_virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_spoke_aks_name), "virtualNetworkName", local.virtual_network_spoke_aks_name)
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
    peering_hub_to_spoke_data = {
      name                         = "peering-hub-to-spoke-data-${local.suffix}-001"
      resource_group_name          = local.resource_group_hub_name
      virtual_network_name         = local.virtual_network_hub_name
      remote_virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_spoke_data_name), "virtualNetworkName", local.virtual_network_spoke_data_name)
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
    peering_spoke_aks_to_hub = {
      name                         = "peering-spoke-aks-to-hub-${local.suffix}-001"
      resource_group_name          = local.resource_group_spoke_aks_name
      virtual_network_name         = local.virtual_network_spoke_aks_name
      remote_virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_hub_name), "virtualNetworkName", local.virtual_network_hub_name)
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
    peering_spoke_data_to_hub = {
      name                         = "peering-spoke-data-to-hub-${local.suffix}-001"
      resource_group_name          = local.resource_group_spoke_data_name
      virtual_network_name         = local.virtual_network_spoke_data_name
      remote_virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_hub_name), "virtualNetworkName", local.virtual_network_hub_name)
      allow_virtual_network_access = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      use_remote_gateways          = false
    }
  }

  private_dns_zones = {
    pdns_zone_spoke_aks = {
      name                = "privatelink.${local.location}.azmk8s.io"
      resource_group_name = local.resource_group_spoke_aks_name
      location            = local.location
      tags = merge(var.tags, {
        type      = "privateDnsZone"
        
      })
    }
    pdns_zone_spoke_data = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = local.resource_group_spoke_data_name
      location            = local.location
      tags = merge(var.tags, {
        type      = "privateDnsZone"
        
      })
    }
  }

  private_dns_zone_virtual_network_links = {
    pdns_vnet_link_aks_hub = {
      name                  = "pdns-vnet-link-aks-hub-${local.suffix}-001"
      resource_group_name   = local.resource_group_spoke_aks_name
      private_dns_zone_name = local.private_dns_zones.pdns_zone_spoke_aks.name
      virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_hub_name), "virtualNetworkName", local.virtual_network_hub_name)
      registration_enabled  = false
    }
    pdns_vnet_link_aks_spoke = {
      name                  = "pdns-vnet-link-aks-spoke-${local.suffix}-001"
      resource_group_name   = local.resource_group_spoke_aks_name
      private_dns_zone_name = local.private_dns_zones.pdns_zone_spoke_aks.name
      virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_spoke_aks_name), "virtualNetworkName", local.virtual_network_spoke_aks_name)
      registration_enabled  = true
    }
    pdns_vnet_link_data_hub = {
      name                  = "pdns-vnet-link-data-hub-${local.suffix}-001"
      resource_group_name   = local.resource_group_spoke_data_name
      private_dns_zone_name = local.private_dns_zones.pdns_zone_spoke_data.name
      virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_hub_name), "virtualNetworkName", local.virtual_network_hub_name)
      registration_enabled  = false
    }
    pdns_vnet_link_data_spoke = {
      name                  = "pdns-vnet-link-data-spoke-${local.suffix}-001"
      resource_group_name   = local.resource_group_spoke_data_name
      private_dns_zone_name = local.private_dns_zones.pdns_zone_spoke_data.name
      virtual_network_id    = replace(replace(local.virtual_network_template_id, "resourceGroupName", local.resource_group_spoke_data_name), "virtualNetworkName", local.virtual_network_spoke_data_name)
      registration_enabled  = true
    }
  }

  user_assigned_identities = {
    aks_identity = {
      location            = local.location
      name                = local.aks_identity_name
      resource_group_name = local.resource_group_spoke_aks_name

      tags = merge(var.tags, {
        type      = "userAssignedIdentity"
        
      })
    }
  }

  role_assignments = {
    aks_identity_pdnsz = {
      role_definition_name = "Private DNS Zone Contributor"
      scope                = data.azurerm_private_dns_zone.pdnsz.id
      principal_id         = module.user_assigned_identity.principal_id["aks_identity"]
    }
    aks_identity_vnet = {
      role_definition_name = "Network Contributor"

      scope = data.azurerm_subnet.subnet_spoke_aks.id

      principal_id = module.user_assigned_identity.principal_id["aks_identity"]
    }
    # aks_identity_acr_pull = {
    #   role_definition_name = "AcrPull"
    #   scope                = data.azurerm_container_registry.acr.id
    #   principal_id         = module.user_assigned_identity.principal_id["aks_identity"]
    # }
    # aks_identity_acr_push = {
    #   role_definition_name = "AcrPush"
    #   scope                = data.azurerm_container_registry.acr.id
    #   principal_id         = module.user_assigned_identity.principal_id["aks_identity"]
    # }
  }

  kubernetes_clusters = {
    aks-cluster = {
      name                = local.aks_cluster_name
      location            = local.location
      resource_group_name = local.resource_group_spoke_aks_name
      dns_prefix          = "${local.aks_cluster_name}"
      kubernetes_version  = null

      private_cluster_enabled             = true
      private_dns_zone_id                 = data.azurerm_private_dns_zone.pdnsz.id
      private_cluster_public_fqdn_enabled = false

      role_based_access_control_enabled = true

      default_node_pool = {
        name            = "system"
        node_count      = 2
        min_count       = 2
        max_count       = 3
        vm_size         = "Standard_D2s_v3"
        os_disk_size_gb = 30

        upgrade_settings = {
          max_surge = "25%"
        }

        vnet_subnet_id = data.azurerm_subnet.subnet_spoke_aks.id
      }

      identity = {
        type = "UserAssigned"
        identity_ids = [
          module.user_assigned_identity.id["aks_identity"]
        ]
      }

      network_profile = {
        network_plugin    = "azure"
        network_policy    = "calico"
        network_plugin_mode = "overlay"
      }

      tags = merge(var.tags, 
      {
        type      = "azureKubernetesCluster"
        
      })
    }
  }
}