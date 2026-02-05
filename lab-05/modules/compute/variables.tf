variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "location" {
  description = "Regiao do Azure"
  type        = string
}

variable "vm_name" {
  description = "Nome da VM"
  type        = string
}

variable "vm_size" {
  description = "Tamanho da VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuario administrador da VM"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key" {
  description = "Chave publica SSH para acesso a VM"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a VM sera conectada"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}