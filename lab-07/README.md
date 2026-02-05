# Lab 07 - Conditional Resources

## Sobre este Lab

Criação condicional de recursos usando o operador ternário e count. Um recurso só é criado se uma variável booleana for true.

## O que foi feito

- Resource Group (sempre criado)
- Public IP (criado apenas se var.criar_public_ip = true)

## Estrutura de Arquivos

```
lab-07-conditional/
├── main.tf           # Provider, RG e Public IP condicional
├── variables.tf      # Variáveis incluindo criar_public_ip (bool)
├── terraform.tfvars  # Valores
├── outputs.tf        # Nome do RG e IP (se existir)
└── README.md
```

## Conceitos que aprendi

**Operador ternário**

```hcl
condição ? valor_se_verdadeiro : valor_se_falso
```

Exemplos:

```hcl
count    = var.criar_public_ip ? 1 : 0
location = var.ambiente == "prod" ? "eastus" : "centralus"
vm_size  = var.ambiente == "prod" ? "Standard_D4s_v3" : "Standard_B1s"
```

**count para condicional**

Quando `count = 0`, o recurso não é criado. Quando `count = 1`, é criado uma vez.

```hcl
resource "azurerm_public_ip" "main" {
  count = var.criar_public_ip ? 1 : 0
  ...
}
```

**Recurso com count vira lista**

Quando usa count, o recurso vira uma lista. Pra acessar: `azurerm_public_ip.main[0].id`

**Output condicional**

O output também precisa verificar se o recurso existe:

```hcl
output "public_ip_address" {
  value = var.criar_public_ip ? azurerm_public_ip.main[0].ip_address : "Nenhum IP criado"
}
```

## Resultado dos testes

Com `criar_public_ip = false`:

```
Plan: 1 to add (só RG)
public_ip_address = "Nenhum IP criado"
```

Com `criar_public_ip = true`:

```
Plan: 2 to add (RG + Public IP)
public_ip_address = (known after apply)
```

## Casos de uso reais

- Criar Public IP apenas em ambiente dev (prod usa Load Balancer)
- Criar disco extra apenas se a aplicação precisar
- Criar bastion host apenas em ambiente de homologação
- Habilitar backup apenas em produção

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/expressions/conditionals
- https://developer.hashicorp.com/terraform/language/meta-arguments/count