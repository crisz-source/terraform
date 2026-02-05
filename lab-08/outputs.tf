output "nsg_id" {
  description = "ID do NSG"
  value       = azurerm_network_security_group.main.id
}

output "nsg_rules_count" {
  description = "Quantidade de regras"
  value       = length(var.nsg_rules)
}