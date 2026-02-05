# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = local.nome_rg
  location = var.location
  tags     = local.tags_comuns
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "main" {
  name                = local.nome_vnet
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_lab_stateremote
  tags                = local.tags_comuns
}

resource "azurerm_subnet" "main" {
  for_each = var.subnet_prefixes # Loop pelo map de subnets

  name                 = each.key # Nome da subnet (chave do map)
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value] # CIDR (valor do map)
}


resource "azurerm_network_security_group" "main" {
  name                = local.nome_nsg
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags_comuns

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}