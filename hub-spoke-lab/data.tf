data "azurerm_private_dns_zone" "pdnsz" {
  name                = "privatelink.${local.location}.azmk8s.io"
  resource_group_name = local.resource_group_spoke_aks_name
}

data "azurerm_subnet" "subnet_spoke_aks" {
  name                 = local.subnet_spoke_aks_name
  resource_group_name  = local.resource_group_spoke_aks_name
  virtual_network_name = local.virtual_network_spoke_aks_name
}