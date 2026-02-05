locals {
  ambiente = terraform.workspace

  prefixo = "lab04-${local.ambiente}"

  tags_comuns = merge(var.tags_extras, {
    ambiente   = local.ambiente
    projeto    = "lab04-workspaces"
    gerenciado = "terraform"
    workspace  = terraform.workspace
  })

  nome_rg   = "${local.prefixo}-rg"
  nome_vnet = "${local.prefixo}-vnet"
  nome_nsg  = "${local.prefixo}-nsg"
}