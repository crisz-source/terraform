variable "projeto" {
  description = "Nome do projeto"
  type        = string
}

variable "ambiente" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

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

variable "vm_size" {
  description = "Tamanho da VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuario admin da VM"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key_path" {
  description = "Caminho da chave publica SSH"
  type        = string
}

variable "tags_padrao" {
  description = "Tags aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}