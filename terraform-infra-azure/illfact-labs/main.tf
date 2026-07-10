module "resource_group" {
  source = "../../terraform-modules-azure/base/resource-group"

  resource_groups = local.resource_groups
}

module "virtual_network" {
  source = "../../terraform-modules-azure/network/virtual-network"

  virtual_networks = local.virtual_networks
}

module "subnet" {
  source = "../../terraform-modules-azure/network/subnet"

  subnets = merge(
    local.subnets_hub,
    local.subnets_spoke_aks,
    local.subnets_spoke_data
  )

  depends_on = [module.virtual_network]
}

module "virtual_network_peering" {
  source = "../../terraform-modules-azure/network/virtual-network-peering"

  virtual_network_peerings = local.virtual_network_peerings

  depends_on = [module.virtual_network]
}

module "private_dns_zone" {
  source = "../../terraform-modules-azure/private-dns/private-dns-zone"

  private_dns_zones = local.private_dns_zones
}

module "private_dns_zone_virtual_network_link" {
  source = "../../terraform-modules-azure/private-dns/private-dns-zone-link"

  private_dns_zone_virtual_network_links = merge(
    local.private_dns_zone_links_vnet_hub,
    local.private_dns_zone_links_vnet_spoke_aks,
    local.private_dns_zone_links_vnet_spoke_data
  )

  depends_on = [module.private_dns_zone]
}

# module "container_registry" {
#   source = "../../terraform-modules-azure/container/container-registry"

#   container_registries = local.container_registries
# }

module "user_assigned_identity" {
  source = "../../terraform-modules-azure/authorization/user-assigned-identity"

  user_assigned_identities = local.user_assigned_identities
}

module "role_assignment" {
  source = "../../terraform-modules-azure/authorization/role-assignment"

  role_assignments = local.role_assignments

  depends_on = [module.user_assigned_identity]
}

# module "azure_kubernetes_cluster" {
#   source = "../../terraform-modules-azure/container/kubernetes-cluster"

#   azure_kubernetes_clusters = local.kubernetes_clusters

#   depends_on = [module.user_assigned_identity]
# }