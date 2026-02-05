output "resource_group_name" {
  description = "Nome do RG"
  value       = azurerm_resource_group.main.name
}

output "public_ip_address" {
  description = "Endereco do Public IP (se existir)"
  value       = var.criar_public_ip ? azurerm_public_ip.main[0].ip_address : "Nenhum IP criado"
}