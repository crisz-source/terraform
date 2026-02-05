# Lab 08 - Dynamic Blocks

## Sobre este Lab

Uso de dynamic blocks para gerar blocos repetidos dentro de um único recurso. Diferente do for_each que cria múltiplos recursos, o dynamic cria múltiplos blocos internos.

## O que foi feito

- Resource Group
- NSG com 3 regras geradas dinamicamente (SSH, HTTP, HTTPS)

## Estrutura de Arquivos

```
lab-08-dynamic/
├── main.tf           # Provider, RG e NSG com dynamic block
├── variables.tf      # Variáveis incluindo lista de regras
├── terraform.tfvars  # Valores com as 3 regras definidas
├── outputs.tf        # ID do NSG e contagem de regras
└── README.md
```

## Conceitos que aprendi

**Sintaxe do dynamic block**

```hcl
dynamic "nome_do_bloco" {
  for_each = var.lista
  content {
    campo = nome_do_bloco.value.atributo
  }
}
```

- `"nome_do_bloco"` - Nome do bloco que será repetido (ex: security_rule)
- `for_each` - Lista ou map para iterar
- `content` - Conteúdo de cada bloco gerado
- `nome_do_bloco.value` - Acessa o item atual da iteração

**Exemplo prático**

```hcl
resource "azurerm_network_security_group" "main" {
  name = "meu-nsg"
  ...

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                   = security_rule.value.name
      priority               = security_rule.value.priority
      direction              = security_rule.value.direction
      access                 = security_rule.value.access
      protocol               = security_rule.value.protocol
      destination_port_range = security_rule.value.destination_port_range
      ...
    }
  }
}
```

**Variável como lista de objetos**

```hcl
variable "nsg_rules" {
  type = list(object({
    name                   = string
    priority               = number
    direction              = string
    access                 = string
    protocol               = string
    destination_port_range = string
  }))
}
```

## Diferença entre for_each e dynamic

| for_each em resource | dynamic block |
|---------------------|---------------|
| Cria múltiplos recursos | Cria múltiplos blocos dentro de 1 recurso |
| Cada item é um recurso separado no state | Tudo fica em 1 recurso no state |
| Mais controle individual | Código mais compacto |
| Mudar 1 item não afeta outros | Mudar 1 item pode recriar o recurso |

**Exemplo for_each (Lab 03):**

```
azurerm_network_security_group.this (1 recurso)
azurerm_network_security_rule.this["AllowSSH"] (recurso separado)
azurerm_network_security_rule.this["AllowHTTP"] (recurso separado)
azurerm_network_security_rule.this["AllowHTTPS"] (recurso separado)
Total: 4 recursos
```

**Exemplo dynamic (Lab 08):**

```
azurerm_network_security_group.main (1 recurso com 3 regras dentro)
Total: 1 recurso
```

## Resultado do teste

```
Plan: 2 to add (RG + NSG)
nsg_rules_count = 3
```

O NSG é um único recurso contendo as 3 regras embutidas.

## Casos de uso reais

- Regras de NSG que raramente mudam
- Blocos de tags dinâmicos
- Configurações de rede em VMs
- Múltiplos discos em uma VM
- Regras de firewall

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group