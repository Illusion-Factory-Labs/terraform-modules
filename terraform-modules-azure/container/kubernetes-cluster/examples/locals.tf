locals {
  location    = var.location
  environment = var.environment
  app_name    = var.app_name
  suffix      = "${local.app_name}-${local.environment}"

  aks_cluster_name  = "aks-runner-${local.suffix}-001"
  aks_identity_name = "id-runner-${local.suffix}-001"

  user_assigned_identities = {
    aks_identity = {
      location            = var.location
      name                = local.aks_identity_name
      resource_group_name = var.resource_group.name

      tags = merge(var.tags, {
        Component = "Identity"
        Purpose   = "AKS-Cluster-Identity"
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

      scope = data.azurerm_subnet.subnet.id

      principal_id = module.user_assigned_identity.principal_id["aks_identity"]
    }
  }

  azure_kubernetes_clusters = {
    aks-cluster = {
      name                = local.aks_cluster_name
      location            = local.location
      resource_group_name = var.resource_group.name
      dns_prefix          = "${local.aks_cluster_name}-dns"
      kubernetes_version  = var.kubernetes_version

      private_cluster_enabled             = true
      private_dns_zone_id                 = data.azurerm_private_dns_zone.pdnsz.id
      private_cluster_public_fqdn_enabled = false

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

        vnet_subnet_id = data.azurerm_subnet.subnet.id
      }

      identity = {
        type = "UserAssigned"
        identity_ids = [
          module.user_assigned_identity.id["aks_identity"]
        ]
      }
    }
  }
}
