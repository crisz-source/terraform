
locals {
  # Padrão de nomenclatura: projeto-ambiente-recurso
  # Exemplo: webapp-dev-rg, webapp-dev-vnet
  prefixo = "${var.projeto}-${var.ambiente}"

  # Tags padrão + tags calculadas
  tags_comuns = merge(var.tags_padrao, {
    ambiente     = var.ambiente
    projeto      = var.projeto
    gerenciado   = "terraform"
    data_criacao = timestamp()
  })

  # Nome dos recursos seguindo convenção
  nome_rg   = "${local.prefixo}-rg"
  nome_vnet = "${local.prefixo}-vnet"
  nome_nsg  = "${local.prefixo}-nsg"
}
