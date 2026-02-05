output "resource_group_name" {
  description = "RG criado: "
  value       = azurerm_resource_group.main.name
}


output "vnet_name" {
  description = "Nome da VNet"
  value       = azurerm_virtual_network.main.name
}


output "nsg_id" {
  description = "ID do Network Security Group"
  value       = azurerm_network_security_group.main.id
}
