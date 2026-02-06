terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "lab10-provisioner-rg"
  location = var.location

  # Provisioner local-exec: roda na sua máquina após criar o recurso
  provisioner "local-exec" {
    command = "echo 'Resource Group ${self.name} criado em ${self.location}' >> provisioner.log"
  }

  # Provisioner que roda quando o recurso é destruído
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Resource Group destruido em ${timestamp()}' >> provisioner.log"
  }
}

# Exemplo de null_resource: recurso que não cria nada, só executa provisioners
resource "null_resource" "exemplo" {
  # Triggers: quando mudar, o provisioner roda novamente
  triggers = {
    ambiente = var.ambiente
  }

  provisioner "local-exec" {
    command = "echo 'Ambiente: ${var.ambiente} - Executado em: ${timestamp()}' >> provisioner.log"
  }
}