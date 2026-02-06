output "resource_group_name" {
  description = "Nome do RG"
  value       = azurerm_resource_group.main.name
}

output "log_file" {
  description = "Arquivo de log criado pelo provisioner"
  value       = "provisioner.log"
}