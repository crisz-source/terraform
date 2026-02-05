output "vm_id" {
  description = "ID da VM"
  value       = azurerm_linux_virtual_machine.this.id
}

output "vm_name" {
  description = "Nome da VM"
  value       = azurerm_linux_virtual_machine.this.name
}

output "private_ip" {
  description = "IP privado da VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "IP publico da VM"
  value       = azurerm_public_ip.this.ip_address
}

output "admin_username" {
  description = "Usuario administrador"
  value       = var.admin_username
}