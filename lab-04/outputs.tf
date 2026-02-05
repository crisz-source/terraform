output "ambiente" {
  description = "Workspace ativo"
  value       = terraform.workspace
}

output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_resource_group.main.name
}

output "vnet_name" {
  description = "Nome da VNet"
  value       = module.networking.vnet_name
}

output "subnet_ids" {
  description = "IDs das subnets"
  value       = module.networking.subnet_ids
}

output "nsg_id" {
  description = "ID do NSG"
  value       = module.networking.nsg_id
}