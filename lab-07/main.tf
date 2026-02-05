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

locals {
  prefixo = "lab07-${var.ambiente}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefixo}-rg"
  location = var.location
}

# Este recurso só é criado se var.criar_public_ip = true
resource "azurerm_public_ip" "main" {
  count = var.criar_public_ip ? 1 : 0

  name                = "${local.prefixo}-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}