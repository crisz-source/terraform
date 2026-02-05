locals {
  prefixo = "${var.projeto}-${var.ambiente}"

  tags_comuns = merge(var.tags_padrao, {
    ambiente   = var.ambiente
    projeto    = var.projeto
    gerenciado = "cristhian"
  })

  nome_rg   = "${local.prefixo}-rg"
  nome_vnet = "${local.prefixo}-vnet"
  nome_nsg  = "${local.prefixo}-nsg"
}