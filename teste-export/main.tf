resource "azurerm_resource_group" "res-0" {
  location = "centralus"
  name     = "rg-importado"
  tags = {
    ambiente   = "dev"
    criado_por = "portal"
  }
}
