# ============================================
# PUBLIC IP
# ============================================
# Endereço público pra acessar a VM de fora.
# Static = o IP não muda quando a VM reinicia.
# ============================================
resource "azurerm_public_ip" "this" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ============================================
# NETWORK INTERFACE (NIC)
# ============================================
# Conecta a VM à subnet.
# É o elo entre a VM e a rede.
# Recebe um IP privado da subnet (Dynamic)
# e associa o Public IP.
# ============================================
resource "azurerm_network_interface" "this" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# ============================================
# DATA SOURCE - IMAGEM UBUNTU
# ============================================
# Consulta o Azure pra buscar a versao mais
# recente do Ubuntu 22.04 LTS.
# Nao cria nada, só busca informação.
# ============================================
data "azurerm_platform_image" "ubuntu" {
  location  = var.location
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
}

# ============================================
# VIRTUAL MACHINE
# ============================================
resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  tags                = var.tags

  # Conecta a NIC à VM
  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  # Autenticação por chave SSH (sem senha)
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  # Imagem do SO (Ubuntu 22.04)
  source_image_reference {
    publisher = data.azurerm_platform_image.ubuntu.publisher
    offer     = data.azurerm_platform_image.ubuntu.offer
    sku       = data.azurerm_platform_image.ubuntu.sku
    version   = data.azurerm_platform_image.ubuntu.version
  }

  # Disco do SO
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Desabilita autenticação por senha
  disable_password_authentication = true
}