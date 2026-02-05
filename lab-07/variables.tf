variable "location" {
  description = "Regiao do Azure"
  type        = string
  default     = "centralus"
}

variable "ambiente" {
  description = "Ambiente (dev ou prod)"
  type        = string
  default     = "dev"
}

variable "criar_public_ip" {
  description = "Se true, cria Public IP. Se false, nao cria."
  type        = bool
  default     = false
}