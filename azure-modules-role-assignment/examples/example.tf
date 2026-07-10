data "azurerm_resource_group" "rg" {
  name = local.resource_group_name
}

data "azurerm_user_assigned_identity" "uami-example-01" {
  name                = local.user_assigned_identities["uami-example-01"].name
  resource_group_name = local.user_assigned_identities["uami-example-01"].resource_group_name
}

locals {
  resource_group_name = "rg-terraform-examples"

  user_assigned_identities = {
    "uami-example-01" = {
      create              = false
      name                = "uami-example-01"
      location            = "brazilsouth"
      resource_group_name = local.resource_group_name
      isolation_scope     = "Regional"

      tags = {
        environment = "dev"
        project     = "project1"
      }
    },
    "uami-example-02" = {
      create              = true
      name                = "uami-example-02"
      location            = "brazilsouth"
      resource_group_name = local.resource_group_name
      isolation_scope     = "Regional"

      tags = {
        environment = "prod"
        project     = "project2"
      }
    }
  }

  role_assignments = {
    ra-example-01 = {
      role_definition_name = "Reader"
      scope                = data.azurerm_resource_group.rg.id
      principal_id         = data.azurerm_user_assigned_identity.uami-example-01.principal_id
    }
    ra-example-02 = {
      role_definition_name = "Reader"
      scope                = data.azurerm_resource_group.rg.id
      principal_id         = module.user_assigned_identity.principal_id["uami-example-02"]
    }
  }

}

module "user_assigned_identity" {
  source = "../../user_assigned_identity"

  user_assigned_identities = { for k, v in local.user_assigned_identities : k => v if v.create }
}

module "role_assignment" {
  source = "../"

  role_assignments = local.role_assignments
}
