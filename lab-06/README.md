# Lab 06 - Import

## Sobre este Lab

Importação de recursos existentes no Azure pro state do Terraform. Quando alguém cria algo pelo portal ou CLI manualmente, o Terraform não sabe que existe. O import registra esse recurso no state sem recriar ele.

## O que foi feito

- Criação manual de um Resource Group pelo CLI (simulando criação pelo portal)
- Escrita do código Terraform correspondente
- Import do recurso pro state
- Modificação do recurso via Terraform (adicionando tag)

## Estrutura de Arquivos

```
lab-06-import/
├── main.tf      # Provider e recurso importado
├── outputs.tf   # ID e nome do RG
└── README.md
```

## Fluxo do Import

```
1. Recurso existe no Azure (criado manualmente)
2. Escrever o código .tf correspondente
3. terraform import pra conectar código ao recurso real
4. A partir de agora, terraform plan/apply gerencia ele
```

Importante: o import não gera código automaticamente. Você escreve o .tf primeiro, depois importa.

## Conceitos que aprendi

**Import não gera código**

Você precisa escrever o bloco resource antes de importar. O código deve corresponder exatamente ao recurso real: mesmo nome, região e configurações.

**Sem import, o Terraform tenta criar**

Se o recurso existe no Azure mas não está no state, o Terraform não sabe. Ele tenta criar e recebe erro "already exists".

**Depois do import, Terraform gerencia**

Qualquer mudança no código é aplicada no recurso importado. Ele passa a fazer parte do ciclo normal de plan/apply/destroy.

## Como executar

Criar o recurso manualmente:

```bash
az group create --name rg-importado --location centralus --tags ambiente=dev criado_por=portal
```

Escrever o main.tf correspondente, inicializar e ver o plan antes do import:

```bash
terraform init
terraform plan
# Mostra: Plan: 1 to add (quer criar porque não sabe que existe)
```

Pegar o ID do recurso e importar:

```bash
az group show --name rg-importado --query id --output tsv
terraform import azurerm_resource_group.importado "/subscriptions/SEU_ID/resourceGroups/rg-importado"
```

Verificar que agora está no state:

```bash
terraform plan
# Mostra: No changes (agora sabe que existe)
```

## Import em escala

Pra importar uma infraestrutura completa (ex: AKS com dezenas de recursos), escrever cada .tf manualmente é trabalhoso. Existem ferramentas que ajudam:

**aztfexport** - Ferramenta da Microsoft que lê os recursos do Azure e gera o código .tf automaticamente:

```bash
aztfexport resource-group rg-aks
```

**terraform plan -generate-config-out** (Terraform 1.5+) - Gera código a partir de blocos import:

```hcl
import {
  to = azurerm_resource_group.exemplo
  id = "/subscriptions/.../resourceGroups/rg-aks"
}
```

```bash
terraform plan -generate-config-out=generated.tf
```

## Teste prático com aztfexport

Instalei o aztfexport pra testar a exportação automática:

```bash
# Instalar Go 1.23+
wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
export PATH=/usr/local/go/bin:$HOME/go/bin:$PATH

# Instalar aztfexport
go install github.com/Azure/aztfexport@latest
```

Criei uma pasta vazia e exportei o resource group:

```bash
mkdir ~/terraform-learning/teste-export
cd ~/terraform-learning/teste-export
aztfexport resource-group rg-importado
```

O aztfexport abriu uma interface interativa listando os recursos encontrados. Pressionei `w` pra importar e gerar os arquivos .tf.

Ele gerou 3 arquivos automaticamente:

**main.tf** - Bloco terraform com backend e required_providers

**provider.tf** - Configuração do provider azurerm

**res-0.tf** - O resource group com todas as configurações

O código gerado corresponde exatamente ao recurso no Azure, incluindo tags. Ao rodar `terraform plan`, mostra `No changes`.

Pra uma infraestrutura maior (ex: AKS completo), o aztfexport gera um arquivo pra cada recurso. Depois é só refatorar: organizar em módulos, criar variáveis e limpar o código.

## Documentação consultada

- https://developer.hashicorp.com/terraform/cli/import
- https://developer.hashicorp.com/terraform/language/import
- https://github.com/Azure/aztfexport