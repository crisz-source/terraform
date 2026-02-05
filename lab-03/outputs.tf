output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID do Resource Group"
  value       = azurerm_resource_group.main.id
}

output "vnet_id" {
  description = "ID da VNet (vem do modulo)"
  value       = module.networking.vnet_id
}

output "vnet_name" {
  description = "Nome da VNet (vem do modulo)"
  value       = module.networking.vnet_name
}

output "subnet_ids" {
  description = "IDs das subnets (vem do modulo)"
  value       = module.networking.subnet_ids
}

output "nsg_id" {
  description = "ID do NSG (vem do modulo)"
  value       = module.networking.nsg_id
}