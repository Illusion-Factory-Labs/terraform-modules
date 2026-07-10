resource "azurerm_container_registry" "acr" {
    for_each = var.container_registries

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku

  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  zone_redundancy_enabled       = each.value.zone_redundancy_enabled
  anonymous_pull_enabled        = each.value.anonymous_pull_enabled
  data_endpoint_enabled         = each.value.data_endpoint_enabled
  network_rule_bypass_option    = each.value.network_rule_bypass_option
  quarantine_policy_enabled     = each.value.quarantine_policy_enabled
  trust_policy_enabled          = each.value.trust_policy_enabled
  export_policy_enabled         = each.value.export_policy_enabled
  
  tags = each.value.tags
}