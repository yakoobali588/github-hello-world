data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "agic" {
  name                = "${var.aks_name}-agic-uai"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  sku_tier = "Standard"

  default_node_pool {
    name                         = "system"
    node_count                   = var.node_count
    vm_size                      = var.vm_size
    vnet_subnet_id               = var.subnet_id
    orchestrator_version         = var.kubernetes_version
    # min_count                    = 3
    # max_count                    = 6
    #zones                        = ["1", "2", "3"]
    only_critical_addons_enabled = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
  network_plugin     = "azure"
  service_cidr       = "10.240.0.0/16"
  dns_service_ip     = "10.240.0.10"
  #docker_bridge_cidr = "172.17.0.1/16"
}

  role_based_access_control_enabled = true

  ingress_application_gateway {
    gateway_id = var.app_gateway_id
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "agic_reader_rg" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Reader"
  principal_id         = azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

resource "azurerm_role_assignment" "agic_contributor_appgw" {
  scope                = var.app_gateway_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}
