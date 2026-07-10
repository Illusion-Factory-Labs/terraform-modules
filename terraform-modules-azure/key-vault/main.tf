resource "azurerm_key_vault" "kv" {
  for_each = var.key_vaults

  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  location                          = each.value.location
  sku_name                          = each.value.sku_name
  tenant_id                         = each.value.tenant_id
  tags                              = each.value.tags

  enabled_for_disk_encryption       = each.value.enabled_for_disk_encryption
  soft_delete_retention_days        = each.value.soft_delete_retention_days
  purge_protection_enabled          = each.value.purge_protection_enabled
}