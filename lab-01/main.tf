# ============================================
# MAIN.TF - Recursos Principais
# DEFININDO A VERSÃO DO TERRAFORM E AZURE
# ============================================

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# ============================================
# BAIXANDO O REUCSO DA NUVEM
# ============================================
provider "azurerm" {
  features {}
}

# ============================================
# RESOURCE GROUP
# ============================================
resource "azurerm_resource_group" "main" {
  name     = local.nome_rg
  location = var.location
  tags     = local.tags_comuns
}

# ============================================
# VIRTUAL NETWORK
# ============================================
resource "azurerm_virtual_network" "main" {
  name                = local.nome_vnet
  location            = azurerm_resource_group.main.location  
  resource_group_name = azurerm_resource_group.main.name      
  address_space       = var.vnet_address_space
  tags                = local.tags_comuns
}

# ============================================
# SUBNETS - Usando for_each (loop)
# ============================================
resource "azurerm_subnet" "main" {
  for_each = var.subnet_prefixes  # Loop pelo map de subnets
  
  name                 = each.key                              # Nome da subnet (chave do map)
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]                          # CIDR (valor do map)
}

# ============================================
# NETWORK SECURITY GROUP
# ============================================
resource "azurerm_network_security_group" "main" {
  name                = local.nome_nsg
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags_comuns

  # Regra: Liberar SSH (porta 22) - APENAS PARA LAB!
  # Em produção, isso seria um problema de segurança
security_rule {
  name                       = "AllowSSH"        # Nome da regra (só identificação)
  priority                   = 100               # Ordem de avaliação (menor = primeiro)
  direction                  = "Inbound"         # Entrada ou Saída
  access                     = "Allow"           # Permitir ou Bloquear
  protocol                   = "Tcp"             # TCP, UDP ou * (ambos)
  source_port_range          = "*"               # Porta de origem (geralmente *)
  destination_port_range     = "22"              # Porta de destino (SSH = 22)
  source_address_prefix      = "*"               # De onde vem o tráfego
  destination_address_prefix = "*"               # Pra onde vai
}

  # Regra: Liberar HTTP (porta 80)
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regra: Liberar HTTPS (porta 443)
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# ============================================
# ASSOCIAR NSG À SUBNET DE APP
# ============================================
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.main["subnet-app"].id  # Referência com índice
  network_security_group_id = azurerm_network_security_group.main.id
}
