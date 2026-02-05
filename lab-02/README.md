# Lab 02

## Sobre este Lab

Configuração de backend remoto para armazenar o Terraform State no Azure Blob Storage. Isso permite trabalho em equipe e evita conflitos com locking automático.

## O que foi criado

- Storage Account dedicado para armazenar o state
- Container chamado "tfstate"
- Mesma infraestrutura do Lab 01 (RG, VNet, Subnet, NSG)
- State armazenado remotamente ao invés de local

## Estrutura de Arquivos

```
lab-02-state-remoto/
├── main.tf           # Provider e recursos
├── backend.tf        # Configuração do backend remoto
├── variables.tf      # Declaração de variáveis
├── terraform.tfvars  # Valores das variáveis
├── locals.tf         # Variáveis calculadas
├── outputs.tf        # Outputs após apply
└── README.md
```

## Configuração do Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate8c9c8b3a"
    container_name       = "tfstate"
    key                  = "lab-02.tfstate"
  }
}
```

O parâmetro `key` define o nome do arquivo de state. Cada projeto ou ambiente deve ter um key diferente.

## Conceitos que aprendi

**Por que usar State Remoto**

Com state local, só uma pessoa consegue trabalhar no projeto. Se duas pessoas rodarem apply ao mesmo tempo, o state fica inconsistente. Com state remoto no Azure Blob, o Terraform usa lease locking pra garantir que só uma pessoa aplica mudanças por vez.

**Locking**

Quando alguém roda `terraform apply`, o Terraform adquire um lease no blob. Se outra pessoa tentar aplicar ao mesmo tempo, recebe um erro informando quem está segurando o lock.

**Migração de State**

Pra migrar de state local pra remoto, basta adicionar o arquivo `backend.tf` e rodar `terraform init -migrate-state`. O Terraform pergunta se quer copiar o state existente pro novo backend.

## Como executar

Primeiro, criar o Storage Account pro state:

```bash
az group create --name rg-terraform-state --location brazilsouth

az storage account create \
  --name sttfstateXXXXXXXX \
  --resource-group rg-terraform-state \
  --location brazilsouth \
  --sku Standard_LRS

az storage container create \
  --name tfstate \
  --account-name sttfstateXXXXXXXX
```

Depois, atualizar o `backend.tf` com o nome do Storage Account criado e executar:

```bash
az login
terraform init
terraform plan
terraform apply
```

Para verificar o state remoto:

```bash
terraform state list
```

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/backend
- https://developer.hashicorp.com/terraform/language/backend/azurerm
- https://developer.hashicorp.com/terraform/language/state/locking