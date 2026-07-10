locals {
  subnets = {
    subnet1 = {
      name                                          = "subnet1"
      resource_group_name                           = "rg-subnet"
      virtual_network_name                          = "vnet1"
      address_prefixes                              = ["10.0.0.0/24"]
      default_outbound_access_enabled               = true
      private_link_service_network_policies_enabled = true
    }
  }
}
