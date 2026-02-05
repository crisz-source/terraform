variable "projeto" {
  description = "Região do lab-02-state-remoto"
  type        = string
  default     = "lab-02-state-remoto"
}

variable "vnet_address_lab_stateremote" {
  description = "vnet-lab-02-state-remoto"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


variable "subnet_prefixes" {
  description = "CIDRs das Subnets-lab-02-state-remoto"
  type        = map(string)
  default = {
    subnet-app = "10.0.1.0/24"
  }
}


variable "ambiente" {
  description = "Ambiente de deploy dev"
  type        = string
  default     = "dev"

}

variable "location" {
  description = "Região do Azure para deploy"
  type        = string
  default     = "brazilsouth"
}

variable "tags_padrao" {
  description = "Tags aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}