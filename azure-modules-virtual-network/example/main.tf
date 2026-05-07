module "virtual_network" {
  source = "../"

  virtual_networks = local.virtual_networks
  subnets          = local.subnets
}