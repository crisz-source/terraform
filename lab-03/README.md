# Lab 03 - Módulos

## Sobre este Lab

Refatoração da infraestrutura dos labs anteriores usando módulos. Ao invés de criar os recursos direto no main.tf, empacotei a parte de networking num módulo reutilizável.

## O que foi criado

- Resource Group (no projeto principal)
- Módulo networking contendo:
  - Virtual Network (10.0.0.0/16)
  - Duas Subnets (subnet-app e subnet-db)
  - Network Security Group com regras de entrada
  - Associação do NSG com todas as subnets

## Estrutura de Arquivos

```
lab-03-modulos/
├── main.tf              # Cria o RG e chama o módulo
├── variables.tf         # Variáveis do projeto
├── terraform.tfvars     # Valores das variáveis
├── locals.tf            # Prefixo, tags e nomes
├── outputs.tf           # Exibe valores retornados pelo módulo
├── backend.tf           # State remoto (lab-03.tfstate)
├── README.md
└── modules/
    └── networking/
        ├── main.tf      # VNet, Subnets, NSG, regras e associações
        ├── variables.tf # Inputs do módulo
        └── outputs.tf   # IDs e nomes criados
```

## Como o módulo funciona

O módulo é chamado no main.tf do projeto passando parâmetros:

```hcl
module "networking" {
  source = "./modules/networking"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = local.nome_vnet
  address_space       = var.vnet_address_space
  subnets             = var.subnet_prefixes
  nsg_name            = local.nome_nsg
  nsg_rules           = [...]
  tags                = local.tags_comuns
}
```

Os outputs do módulo são acessados com `module.networking.vnet_id`, `module.networking.subnet_ids`, etc.

## Conceitos que aprendi

**Módulos**

Um módulo é uma pasta com arquivos .tf que recebe inputs (variables.tf), cria recursos (main.tf) e retorna outputs (outputs.tf). Funciona como uma função: recebe parâmetros, executa lógica, retorna resultado.

**Convenção "this"**

Dentro de módulos, quando existe só um recurso daquele tipo, a convenção é usar "this" como nome local. Exemplo: `azurerm_virtual_network.this`.

**Regras do NSG separadas**

Criar as regras como recursos separados do NSG permite adicionar/remover regras sem destruir e recriar o NSG inteiro.

**Transformar lista em map pro for_each**

O for_each não aceita lista, só map ou set. Pra criar regras a partir de uma lista, transformei com `{ for rule in var.nsg_rules : rule.name => rule }`.

## Como executar

```bash
az login
terraform init
terraform plan
terraform apply
```

O `terraform init` mostra a inicialização do módulo:

```
Initializing modules...
- networking in modules/networking
```

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/modules
- https://developer.hashicorp.com/terraform/language/modules/syntax
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule