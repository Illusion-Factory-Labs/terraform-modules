module "kubernetes_node_pool" {
  source = "../"

  subscription_id       = var.subscription_id
  kubernetes_node_pools = local.kubernetes_node_pools
}
