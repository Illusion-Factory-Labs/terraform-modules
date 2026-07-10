locals {
  virtual_networks = {
    vnet1 = {
      name                = "vnet1"
      resource_group_name = "rg-virtual-network"
      location            = "brazilsouth"
      address_space       = ["10.0.0.0/16"]
    }
  }
}
