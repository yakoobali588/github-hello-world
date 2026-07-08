resource_group_name = "rg-aks-agic-dev"
location            = "Central India"

vnet_name           = "vnet-aks-agic-dev"
vnet_address_space  = ["10.0.0.0/16"]

aks_subnet_prefixes   = ["10.0.1.0/24"]
appgw_subnet_prefixes = ["10.0.2.0/24"]

acr_name  = "myuniqueacrdev12345"
aks_name  = "aks-agic-dev"
dns_prefix = "aksagicdev"

appgw_name     = "appgw-agic-dev"
appgw_capacity = 2

node_count = 1
vm_size    = "Standard_D4s_v5"

tags = {
  environment = "dev"
  project     = "aks-agic"
  managed_by  = "terraform"
}
