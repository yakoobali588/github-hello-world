module "resource_group" {
  source              = "./modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "network" {
  source                = "./modules/network"
  resource_group_name   = module.resource_group.name
  location              = module.resource_group.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  aks_subnet_name       = "${var.aks_name}-subnet"
  aks_subnet_prefixes   = var.aks_subnet_prefixes
  appgw_subnet_name     = "${var.appgw_name}-subnet"
  appgw_subnet_prefixes = var.appgw_subnet_prefixes
  tags                  = var.tags
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = var.tags
}

module "application_gateway" {
  source              = "./modules/application-gateway"
  appgw_name          = var.appgw_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.appgw_subnet_id
  sku_name            = var.appgw_sku_name
  sku_tier            = var.appgw_sku_tier
  capacity            = var.appgw_capacity
  tags                = var.tags
}

module "aks" {
  source                  = "./modules/aks"
  aks_name                = var.aks_name
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  node_count              = var.node_count
  vm_size                 = var.vm_size
  subnet_id               = module.network.aks_subnet_id
  acr_id                  = module.acr.id
  app_gateway_id          = module.application_gateway.id
  app_gateway_subnet_cidr = var.appgw_subnet_prefixes[0]
  tags                    = var.tags

  depends_on = [
    module.application_gateway
  ]
}
