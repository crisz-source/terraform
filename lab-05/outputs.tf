output "resource_group_name" {
  description = "Nome do Resource Group"
  value       = azurerm_resource_group.main.name
}

output "vnet_name" {
  description = "Nome da VNet"
  value       = module.networking.vnet_name
}

output "vm_name" {
  description = "Nome da VM"
  value       = module.compute.vm_name
}

output "vm_public_ip" {
  description = "IP publico da VM"
  value       = module.compute.public_ip
}

output "vm_private_ip" {
  description = "IP privado da VM"
  value       = module.compute.private_ip
}

output "ssh_command" {
  description = "Comando pra conectar via SSH"
  value       = "ssh -i ~/.ssh/lab05-key ${var.admin_username}@${module.compute.public_ip}"
}