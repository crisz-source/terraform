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

resource "azurerm_resource_group" "importado" {
  name     = "rg-importado"
  location = "centralus"

  tags = {
    ambiente       = "dev"
    criado_por     = "portal"
    gerenciado_por = "terraform"
  }


}
