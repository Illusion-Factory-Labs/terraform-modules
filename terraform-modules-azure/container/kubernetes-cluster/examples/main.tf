module "user_assigned_identity" {
  source = "../terraform-modules-azure/user_assigned_identity"

  user_assigned_identities = local.user_assigned_identities
}

module "role_assignment" {
  source = "../terraform-modules-azure/role-assignment"

  role_assignments = local.role_assignments

  depends_on = [
    module.user_assigned_identity,
    data.azurerm_private_dns_zone.pdnsz
  ]
}

module "kubernetes_cluster" {
  source = "../terraform-modules-azure/kubernetes_cluster"

  subscription_id           = var.subscription_id
  azure_kubernetes_clusters = local.azure_kubernetes_clusters

  depends_on = [
    module.role_assignment,
    data.azurerm_subnet.subnet
  ]
}

