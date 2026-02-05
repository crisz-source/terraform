output "vnet_id" {
  description = "ID da Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Nome da Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map com os IDs das subnets"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "nsg_id" {
  description = "ID do Network Security Group"
  value       = azurerm_network_security_group.this.id
}

output "nsg_name" {
  description = "Nome do Network Security Group"
  value       = azurerm_network_security_group.this.name
}