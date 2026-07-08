variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet CIDR"
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_prefixes" {
  type        = list(string)
  description = "AKS subnet CIDR"
  default     = ["10.0.1.0/24"]
}

variable "appgw_subnet_prefixes" {
  type        = list(string)
  description = "Application Gateway subnet CIDR"
  default     = ["10.0.2.0/24"]
}

variable "acr_name" {
  type        = string
  description = "ACR name, globally unique"
}

variable "aks_name" {
  type        = string
  description = "AKS cluster name"
}

variable "dns_prefix" {
  type        = string
  description = "AKS DNS prefix"
}

variable "node_count" {
  type        = number
  description = "Default node count"
  default     = 3
}

variable "vm_size" {
  type        = string
  description = "AKS node VM size"
  default     = "Standard_D4s_v5"
}

variable "kubernetes_version" {
  type        = string
  description = "AKS Kubernetes version"
  default     = null
}

variable "appgw_name" {
  type        = string
  description = "Application Gateway name"
}

variable "appgw_sku_name" {
  type        = string
  default     = "WAF_v2"
}

variable "appgw_sku_tier" {
  type        = string
  default     = "WAF_v2"
}

variable "appgw_capacity" {
  type        = number
  default     = 2
}

variable "tags" {
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
