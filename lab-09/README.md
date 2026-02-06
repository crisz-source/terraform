# Lab 09 - Lifecycle Rules

## Sobre este Lab

Controle do ciclo de vida dos recursos com lifecycle rules. O Terraform tem um ciclo padrão (detecta diferença → destrói → cria), mas às vezes precisamos mudar esse comportamento.

## O que foi feito

- Resource Group com prevent_destroy (proteção contra destruição)
- Resource Group com ignore_changes (ignora mudanças nas tags)
- Public IP com create_before_destroy (cria novo antes de destruir antigo)

## Estrutura de Arquivos

```
lab-09-lifecycle/
├── main.tf           # Provider e recursos com lifecycle
├── variables.tf      # Variáveis
├── terraform.tfvars  # Valores
├── outputs.tf        # Nomes dos RGs e IP
└── README.md
```

## Conceitos que aprendi

**prevent_destroy**

Impede que o recurso seja destruído, mesmo com terraform destroy. Útil pra proteger recursos críticos como bancos de dados.

```hcl
resource "azurerm_resource_group" "protegido" {
  name     = "rg-producao"
  location = "centralus"

  lifecycle {
    prevent_destroy = true
  }
}
```

Ao tentar destruir:

```
Error: Instance cannot be destroyed
Resource has lifecycle.prevent_destroy set, but the plan calls for this resource to be destroyed.
```

**ignore_changes**

Ignora mudanças em campos específicos. Útil quando algo é modificado fora do Terraform (políticas do Azure, scripts externos).

```hcl
resource "azurerm_resource_group" "ignorar" {
  name     = "rg-ignorar"
  location = "centralus"

  tags = {
    ambiente = "dev"
    manual   = "valor-inicial"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
```

Mesmo alterando as tags no código, o plan mostra `No changes`.

**create_before_destroy**

Cria o novo recurso antes de destruir o antigo. Útil pra zero downtime em recursos como DNS, Load Balancer, Public IP.

```hcl
resource "azurerm_public_ip" "swap" {
  name                = "pip-swap"
  location            = "centralus"
  resource_group_name = "meu-rg"
  allocation_method   = "Static"

  lifecycle {
    create_before_destroy = true
  }
}
```

## Testes realizados

**Teste 1: prevent_destroy**

```bash
terraform destroy -target=azurerm_resource_group.protegido
```

Resultado: Erro bloqueando a destruição.

**Teste 2: ignore_changes**

Alterado o valor da tag no código e rodado plan.

Resultado: `No changes` - Terraform ignorou a mudança.

## Casos de uso reais

| Lifecycle | Caso de uso |
|-----------|-------------|
| prevent_destroy | Banco de dados de produção, Storage Account com dados críticos |
| ignore_changes | Tags adicionadas por políticas do Azure, campos gerenciados por outros processos |
| create_before_destroy | DNS records, Load Balancers, certificates, qualquer recurso que precisa de zero downtime |

## Observação importante

Pra destruir um recurso com prevent_destroy, é necessário primeiro remover a regra do código, rodar apply, e depois rodar destroy.

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle
- https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy
- https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes
- https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#create_before_destroy