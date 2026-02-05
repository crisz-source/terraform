variable "resource_group_name" {
  description = "Nome do Resource Group onde os recursos serao criados"
  type        = string
}

variable "location" {
  description = "Regiao do Azure"
  type        = string
}

variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string
}

variable "address_space" {
  description = "CIDR da VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Map de subnets. Chave = nome, Valor = CIDR"
  type        = map(string)
}

variable "nsg_name" {
  description = "Nome do Network Security Group"
  type        = string
}

variable "nsg_rules" {
  description = "Lista de regras do NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}