# Lab 01

## Sobre este Lab

Primeiro contato com Terraform, onde aprendi a criar infraestrutura básica de rede no Azure usando Infrastructure as Code.

## O que foi criado

- Resource Group
- Virtual Network (10.0.0.0/16)
- Duas Subnets (subnet-app e subnet-db)
- Network Security Group com regras de entrada
- Associação do NSG com a subnet-app

## Estrutura de Arquivos

```
lab-01-fundamentos/
├── main.tf           # Recursos principais
├── variables.tf      # Declaração de variáveis
├── terraform.tfvars  # Valores das variáveis
├── locals.tf         # Variáveis calculadas
├── outputs.tf        # Outputs após apply
└── README.md
```

## Conceitos que aprendi

**Estrutura de um Resource**

Todo recurso no Terraform segue o padrão: tipo, nome local e argumentos. O nome local serve pra referenciar o recurso em outros lugares do código.

**Variáveis vs Locals**

Variáveis são valores que vêm de fora (o usuário define). Locals são calculados internamente, geralmente combinando outras variáveis.

**For Each**

Permite criar múltiplos recursos a partir de um map ou set, sem repetir código. Cada item do map vira uma instância do recurso.

**Referências entre Recursos**

Um recurso pode acessar atributos de outro usando a sintaxe `tipo.nome.atributo`. Isso cria dependências implícitas.

## Como executar

Pré-requisitos: Terraform >= 1.0.0, Azure CLI e uma conta no Azure.

```bash
az login
terraform init
terraform plan
terraform apply
terraform destroy
```

## Documentação consultada

- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group