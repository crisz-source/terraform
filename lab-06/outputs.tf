output "resource_group_id" {
  description = "ID do Resource Group importado"
  value       = azurerm_resource_group.importado.id
}

output "resource_group_name" {
  description = "Nome do Resource Group importado"
  value       = azurerm_resource_group.importado.name
}