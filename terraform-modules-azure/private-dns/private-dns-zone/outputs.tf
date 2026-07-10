output "private_dns_zone_id" {
  value = { for k, v in azurerm_private_dns_zone.pdns_zone : k => v.id }
}