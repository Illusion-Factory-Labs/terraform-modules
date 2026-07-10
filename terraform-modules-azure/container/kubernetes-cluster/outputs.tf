output "kubernetes_cluster_id" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks : k => v.id
  }
}

output "kubernetes_admin_config" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_admin_config
  }
}
