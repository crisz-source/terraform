variable "projeto" {
  description = "Nome do projeto"
  type        = string
}

variable "ambiente" {
  description = "Ambiente (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.ambiente)
    error_message = "Ambiente deve ser: dev, staging ou prod."
  }
}

variable "location" {
  description = "Regiao do Azure"
  type        = string
  default     = "brazilsouth"
}

variable "vnet_address_space" {
  description = "CIDR da VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Map de subnets"
  type        = map(string)
  default = {
    subnet-app = "10.0.1.0/24"
    subnet-db  = "10.0.2.0/24"
  }
}

variable "tags_padrao" {
  description = "Tags aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}