module "rg" { source="./modules/resource-group"}
module "network"{source="./modules/network"}
module "acr"{source="./modules/acr"}
module "appgw"{source="./modules/application-gateway"}
module "aks"{source="./modules/aks"}
