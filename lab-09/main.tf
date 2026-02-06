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


# Este RG não pode ser destruído pelo Terraform
resource "azurerm_resource_group" "protegido" {
  name     = "lab09-protegido-rg"
  location = var.location

#   lifecycle {
#     prevent_destroy = true
#   }
}


# Este RG ignora mudanças nas tags (útil quando Azure adiciona tags automáticas)
resource "azurerm_resource_group" "ignorar" {
  name     = "lab09-ignorar-rg"
  location = var.location

  tags = {
    ambiente = var.ambiente
    manual   = "valor-alterado"
  }

#   lifecycle {
#     ignore_changes = [tags]
#   }
}


# Cria o novo IP Publico antes de destruir o antigo
resource "azurerm_public_ip" "swap" {
  name                = "lab09-swap-pip"
  location            = azurerm_resource_group.ignorar.location
  resource_group_name = azurerm_resource_group.ignorar.name
  allocation_method   = "Static"
  sku                 = "Standard"

#   lifecycle {
#     create_before_destroy = true
#   }
}