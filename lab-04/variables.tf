variable "location" {
  description = "Regiao do Azure"
  type        = string
  default     = "brazilsouth"
}

variable "vnet_address_space" {
  description = "CIDR da VNet"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "Map de subnets"
  type        = map(string)
}

variable "tags_extras" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}