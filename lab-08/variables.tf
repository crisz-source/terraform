variable "location" {
  description = "Regiao do Azure"
  type        = string
  default     = "centralus"
}

variable "nsg_rules" {
  description = "Lista de regras do NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    destination_port_range     = string
  }))
}