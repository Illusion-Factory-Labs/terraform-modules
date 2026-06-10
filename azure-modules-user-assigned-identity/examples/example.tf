locals {
  resource_group_name = "rg-terraform-examples"

  user_assigned_identities = {
    "uami-example-01" = {
      name                = "uami-example-01"
      location            = "brazilsouth"
      resource_group_name = local.resource_group_name
      isolation_scope     = "Regional"

      tags = {
        environment = "dev"
        project     = "project1"
      }
    }
  }
}

module "user_assigned_identity" {
  source = "../"

  user_assigned_identities = local.user_assigned_identities
}

output "id" {
  value = module.user_assigned_identity.id
}

output "principal_id" {
  value = module.user_assigned_identity.principal_id
}
