output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "aks_cluster_name" {
  value = module.aks.name
}

output "aks_cluster_id" {
  value = module.aks.id
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "application_gateway_id" {
  value = module.application_gateway.id
}
