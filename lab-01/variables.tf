# ============================================
# VARIABLES.TF - Declaração de Variáveis
# ============================================
# Aqui você DECLARA as variáveis (nome, tipo, descrição)
# Os VALORES ficam no terraform.tfvars
# ============================================

variable "projeto" {
  description = "Nome do projeto (usado em tags e nomes)"
  type        = string
  default     = "lab"
}

variable "ambiente" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.ambiente)
    error_message = "Ambiente deve ser: dev, staging ou prod."
  }
}

variable "location" {
  description = "Região do Azure para deploy"
  type        = string
  default     = "brazilsouth"
}

variable "vnet_address_space" {
  description = "CIDR da VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "CIDRs das Subnets"
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
