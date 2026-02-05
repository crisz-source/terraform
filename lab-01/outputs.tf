# ============================================
# OUTPUTS.TF - Informações de Saída
# ============================================
# Outputs mostram informações após o apply.
# Útil para: ver IDs, IPs, passar dados entre módulos
# ============================================

output "resource_group_name" {
  description = "Nome do Resource Group criado"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID do Resource Group"
  value       = azurerm_resource_group.main.id
}

output "vnet_name" {
  description = "Nome da VNet"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "ID da VNet"
  value       = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  description = "IDs das Subnets criadas"
  value = {
    for k, v in azurerm_subnet.main : k => v.id
  }
}

output "nsg_id" {
  description = "ID do Network Security Group"
  value       = azurerm_network_security_group.main.id
}

# Output sensível - não aparece no console
output "subscription_id" {
  description = "ID da subscription (sensível)"
  value       = azurerm_resource_group.main.id
  sensitive   = true
}
