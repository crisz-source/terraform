# Lab 04 - Workspaces

## Sobre este Lab

Gerenciamento de múltiplos ambientes (dev, staging, prod) usando o mesmo código Terraform. Cada workspace tem seu próprio state, então os recursos de um ambiente não interferem no outro.

## O que foi criado

Mesma infraestrutura para cada workspace, com valores diferentes:

- Resource Group (lab04-dev-rg / lab04-staging-rg)
- Módulo networking com VNet, Subnets, NSG
- Dev usando CIDR 10.1.0.0/16, Staging usando 10.2.0.0/16

## Estrutura de Arquivos

```
lab-04-workspaces/
├── main.tf              # Provider, RG e chamada do módulo
├── variables.tf         # Variáveis do projeto
├── locals.tf            # Usa terraform.workspace pra nomes
├── outputs.tf           # Mostra ambiente ativo e recursos
├── backend.tf           # State remoto (lab-04.tfstate)
├── dev.tfvars           # Valores do ambiente dev
├── staging.tfvars       # Valores do ambiente staging
├── prod.tfvars          # Valores do ambiente prod
├── README.md
└── modules/
    └── networking/      # Mesmo módulo do Lab 03
```

## Como os workspaces funcionam

Cada workspace cria um state separado no backend:

```
tfstate/
├── env:/dev/lab-04.tfstate
├── env:/staging/lab-04.tfstate
└── env:/prod/lab-04.tfstate
```

No código, `terraform.workspace` retorna o nome do workspace ativo. Isso é usado no locals.tf pra gerar nomes e tags diferentes por ambiente:

```hcl
locals {
  ambiente = terraform.workspace
  prefixo  = "lab04-${local.ambiente}"
  nome_rg  = "${local.prefixo}-rg"
}
```

## Conceitos que aprendi

**terraform.workspace**

Retorna o nome do workspace ativo. Substitui a necessidade de uma variável "ambiente" porque o próprio workspace define em qual ambiente você está.

**Arquivos .tfvars por ambiente**

Cada ambiente tem seu arquivo de valores. O `-var-file` na hora do apply indica qual usar. Isso permite CIDRs, tamanhos e configurações diferentes por ambiente.

**Isolamento de state**

Quando troco de workspace, o Terraform enxerga um state diferente. Posso destruir dev sem afetar staging, e vice-versa.

## Como executar

```bash
az login
terraform init

# Deploy em dev
terraform workspace new dev
terraform apply -var-file="dev.tfvars"

# Deploy em staging
terraform workspace new staging
terraform apply -var-file="staging.tfvars"

# Verificar workspaces
terraform workspace list
terraform workspace show

# Destroy por ambiente
terraform workspace select staging
terraform destroy -var-file="staging.tfvars"

terraform workspace select dev
terraform destroy -var-file="dev.tfvars"
```

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/state/workspaces
- https://developer.hashicorp.com/terraform/cli/workspaces
- https://developer.hashicorp.com/terraform/cli/commands/workspace