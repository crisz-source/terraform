output "rg_protegido" {
  description = "RG com prevent_destroy"
  value       = azurerm_resource_group.protegido.name
}

output "rg_ignorar" {
  description = "RG com ignore_changes"
  value       = azurerm_resource_group.ignorar.name
}

output "public_ip" {
  description = "Public IP com create_before_destroy"
  value       = azurerm_public_ip.swap.ip_address
}