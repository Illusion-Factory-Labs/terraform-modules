locals {
  company = "illfact"
  suffix  = "labs"
  tags    = var.tags

  resource_group_name = "rg-${local.company}-${local.suffix}"
  location            = var.location



  # Resource Groups
  resource_groups = {
    "illfact-labs" = {
      name     = local.resource_group_name
      location = local.location

      tags = local.tags
    }
  }

  # Network Resources
  virtual_networks = {
    vnet-hub = {
      name                = "vnet-hub-${local.company}-${local.suffix}"
      resource_group_name = local.resource_group_name
      location            = local.location
      address_space       = ["10.0.0.0/16"]
      tags                = local.tags
    },
    vnet-spoke-aks = {
      name                = "vnet-spoke-aks-${local.company}-${local.suffix}"
      resource_group_name = local.resource_group_name
      location            = local.location
      address_space       = ["10.1.0.0/16"]
      tags                = local.tags
    },
    vnet-spoke-data = {
      name                = "vnet-spoke-data-${local.company}-${local.suffix}"
      resource_group_name = local.resource_group_name
      location            = local.location
      address_space       = ["10.2.0.0/16"]
      tags                = local.tags
    }
  }

  subnets_hub = {
    subnet-hub-shared = {
      name                 = "snet-shared-${local.company}-${local.suffix}"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-hub"].name
      address_prefixes     = ["10.0.1.0/24"]
    },
    subnet-hub-private-endpoints = {
      name                 = "snet-pe-${local.company}-${local.suffix}"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-hub"].name
      address_prefixes     = ["10.0.2.0/24"]
    },
    subnet-hub-bastion = {
      name                 = "AzureBastionSubnet"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-hub"].name
      address_prefixes     = ["10.0.3.0/24"]
    },
    subnet-hub-firewall = {
      name                 = "AzureFirewallSubnet"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-hub"].name
      address_prefixes     = ["10.0.4.0/24"]
    }
  }

  subnets_spoke_aks = {
    subnet-spoke-aks-nodes = {
      name                 = "snet-aks-nodes-${local.company}-${local.suffix}"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-spoke-aks"].name
      address_prefixes     = ["10.1.1.0/24"]
    },
    subnet-spoke-ingress = {
      name                 = "snet-ingress-${local.company}-${local.suffix}"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-spoke-aks"].name
      address_prefixes     = ["10.1.2.0/24"]
    }
  }

  subnets_spoke_data = {
    subnet-spoke-data-private-endpoint = {
      name                 = "snet-pe-${local.company}-${local.suffix}"
      resource_group_name  = local.resource_group_name
      virtual_network_name = local.virtual_networks["vnet-spoke-data"].name
      address_prefixes     = ["10.2.1.0/24"]
    }
  }

  virtual_network_peerings = {
    peering-hub-to-spoke-aks = {
      name                         = "peering-hub-to-spoke-aks-${local.company}-${local.suffix}"
      resource_group_name          = local.resource_group_name
      virtual_network_name         = local.virtual_networks["vnet-hub"].name
      remote_virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-aks"]
      allow_virtual_network_access = true
    },
    peering-spoke-aks-to-hub = {
      name                         = "peering-spoke-aks-to-hub-${local.company}-${local.suffix}"
      resource_group_name          = local.resource_group_name
      virtual_network_name         = local.virtual_networks["vnet-spoke-aks"].name
      remote_virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
      allow_virtual_network_access = true
    },
    peering-hub-to-spoke-data = {
      name                         = "peering-hub-to-spoke-data-${local.company}-${local.suffix}"
      resource_group_name          = local.resource_group_name
      virtual_network_name         = local.virtual_networks["vnet-hub"].name
      remote_virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-data"]
      allow_virtual_network_access = true
    },
    peering-spoke-data-to-hub = {
      name                         = "peering-spoke-data-to-hub-${local.company}-${local.suffix}"
      resource_group_name          = local.resource_group_name
      virtual_network_name         = local.virtual_networks["vnet-spoke-data"].name
      remote_virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
      allow_virtual_network_access = true
    }
  }

  private_dns_zones = {
    private-dns-zone-key-vault = {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = local.resource_group_name
      location            = local.location
      tags                = local.tags
    },
    private-dns-zone-storage = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = local.resource_group_name
      location            = local.location
      tags                = local.tags
    },
    private-dns-zone-database = {
      name                = "privatelink.database.windows.net"
      resource_group_name = local.resource_group_name
      location            = local.location
      tags                = local.tags
    },
    private-dns-zone-container-registry = {
      name                = "privatelink.azurecr.io"
      resource_group_name = local.resource_group_name
      location            = local.location
      tags                = local.tags
    }
  }

  private_dns_zone_links_vnet_hub = {
    private-dns-zone-link-key-vault-hub = {
      name                  = "link-key-vault-hub-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-key-vault"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
    },
    private-dns-zone-link-storage-hub = {
      name                  = "link-storage-hub-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-storage"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
    },
    private-dns-zone-link-database-hub = {
      name                  = "link-database-hub-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-database"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
    },
    private-dns-zone-link-container-registry-hub = {
      name                  = "link-acr-hub-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-container-registry"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-hub"]
    }
  }

  private_dns_zone_links_vnet_spoke_aks = {
    private-dns-zone-link-key-vault-spoke-aks = {
      name                  = "link-key-vault-spoke-aks-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-key-vault"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-aks"]
    },
    private-dns-zone-link-storage-spoke-aks = {
      name                  = "link-storage-spoke-aks-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-storage"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-aks"]
    },
    private-dns-zone-link-database-spoke-aks = {
      name                  = "link-database-spoke-aks-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-database"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-aks"]
    },
    private-dns-zone-link-container-registry-spoke-aks = {
      name                  = "link-acr-spoke-aks-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-container-registry"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-aks"]
    }
  }

  private_dns_zone_links_vnet_spoke_data = {
    private-dns-zone-link-key-vault-spoke-data = {
      name                  = "link-key-vault-spoke-data-${local.company}-${local.suffix}"
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-key-vault"].name
      resource_group_name   = local.resource_group_name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-data"]
    },
    private-dns-zone-link-storage-spoke-data = {
      name                  = "link-storage-spoke-data-${local.company}-${local.suffix}"
      resource_group_name   = local.resource_group_name
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-storage"].name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-data"]
    },
    private-dns-zone-link-database-spoke-data = {
      name                  = "link-database-spoke-data-${local.company}-${local.suffix}"
      resource_group_name   = local.resource_group_name
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-database"].name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-data"]
    },
    private-dns-zone-link-container-registry-spoke-data = {
      name                  = "link-acr-spoke-data-${local.company}-${local.suffix}"
      resource_group_name   = local.resource_group_name
      private_dns_zone_name = local.private_dns_zones["private-dns-zone-container-registry"].name
      virtual_network_id    = module.virtual_network.virtual_network_id["vnet-spoke-data"]
    }
  }

  user_assigned_identities = {
    illfactlabs-identity = {
      name                = "id-aks-fed-${local.company}-${local.suffix}"
      resource_group_name = local.resource_group_name
      location            = local.location

      tags = local.tags
    }
  }

  role_assignments = {
    illfactlabs-identity-role-assignment = {
      role_definition_name = "Reader"
      scope                = "/subscriptions/deac97e0-f6bf-4670-be7f-af2c9935ba77"
      principal_id         = module.user_assigned_identity.principal_id["illfactlabs-identity"]
    }
  }

  container_registries = {
    illfactlabs-container-registry = {
      name                          = "acr${local.company}${local.suffix}"
      resource_group_name           = local.resource_group_name
      location                      = local.location
      sku                           = "Premium"
      public_network_access_enabled = true

      tags = local.tags
    }
  }

  kubernetes_clusters = {
    illfactlabs-aks-cluster = {
      name                = "aks-${local.company}-${local.suffix}"
      resource_group_name = local.resource_group_name
      location            = local.location
      dns_prefix          = "aks-${local.company}-${local.suffix}"

      oidc_issuer_enabled       = true
      workload_identity_enabled = true

      private_cluster_enabled = false

      identity = {
        type = "SystemAssigned"
      }

      default_node_pool = {
        name           = "system"
        vm_size        = "Standard_B2s"
        node_count     = 1
        vnet_subnet_id = module.subnet.subnet_id["subnet-spoke-aks-nodes"]

        upgrade_settings = {
          drain_timeout_in_minutes      = 0
          max_surge                     = "10%"
          node_soak_duration_in_minutes = 0
        }
      }

      network_profile = {
        network_plugin      = "azure"
        network_plugin_mode = "overlay"

        service_cidr   = "172.20.0.0/16"
        dns_service_ip = "172.20.0.10"
      }

      tags = local.tags
    }
  }
}