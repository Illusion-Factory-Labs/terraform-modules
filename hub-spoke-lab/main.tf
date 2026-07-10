module "resource_group" {
  source = "../azure-modules-resource-group"

  resource_groups = local.resource_groups
}

module "virtual_network" {
  source = "../azure-modules-virtual-network"

  virtual_networks         = local.virtual_networks
  subnets                  = local.subnets
  virtual_network_peerings = local.virtual_network_peerings

  depends_on = [module.resource_group]
}

module "private_dns" {
  source = "../azure-modules-private-dns"

  private_dns_zones                      = local.private_dns_zones
  private_dns_zone_virtual_network_links = local.private_dns_zone_virtual_network_links

  depends_on = [module.virtual_network]
}

module "user_assigned_identity" {
  source = "../azure-modules-user-assigned-identity"

  user_assigned_identities = local.user_assigned_identities

  depends_on = [module.resource_group]
}

module "role_assignment" {
  source = "../azure-modules-role-assignment"

  role_assignments = local.role_assignments

  depends_on = [module.user_assigned_identity]
}

module "kubernetes_cluster" {
  source = "../azure-modules-kubernetes-cluster"

  azure_kubernetes_clusters = local.kubernetes_clusters

  depends_on = [ local.role_assignments ]
 
}