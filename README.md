# Terraform Learning - Do Zero ao Avançado

Repositório de estudo de Terraform com foco em Azure. Contém 10 labs práticos que cobrem desde conceitos básicos até provisioners, passando por módulos, state remoto, workspaces e lifecycle rules.

## Objetivo

Aprender Infrastructure as Code (IaC) com Terraform para:

- Provisionar infraestrutura no Azure de forma automatizada
- Organizar código em módulos reutilizáveis
- Gerenciar state de forma segura em ambiente de equipe
- Preparação para certificação HashiCorp Terraform Associate

## Pré-requisitos

- Conta no Azure (Azure for Students ou Pay-as-you-go)
- Azure CLI instalado e autenticado
- Terraform >= 1.0.0
- Conhecimento básico de linha de comando Linux

## Estrutura do Repositório

```
terraform-learning/
├── lab-01-primeiro-recurso/
├── lab-02-variaveis/
├── lab-03-modulos/
├── lab-04-remote-state/
├── lab-05-vm/
├── lab-06-import/
├── lab-07-conditional/
├── lab-08-dynamic/
├── lab-09-lifecycle/
├── lab-10-provisioner/
└── README.md
```

## Labs

### Lab 01 - Primeiro Recurso

Introdução ao Terraform criando um Resource Group no Azure.

**Conceitos:** provider, resource, terraform init, plan, apply, destroy

**Recursos criados:** Resource Group

---

### Lab 02 - Variáveis e Outputs

Parametrização do código com variáveis, locals e outputs.

**Conceitos:** variable, locals, output, terraform.tfvars, tipos de variáveis, validation

**Recursos criados:** Resource Group, VNet, Subnet

---

### Lab 03 - Módulos

Organização do código em módulos reutilizáveis.

**Conceitos:** module, source, inputs, outputs, estrutura de módulos, for_each

**Recursos criados:** Resource Group, VNet, múltiplas Subnets, NSG com regras dinâmicas

---

### Lab 04 - Remote State e Workspaces

State remoto no Azure Blob Storage com locking e workspaces para múltiplos ambientes.

**Conceitos:** backend, state remoto, locking, terraform.workspace, -var-file

**Recursos criados:** Storage Account (state), Resource Group, VNet, Subnets para dev/staging/prod

---

### Lab 05 - VM Completa com SSH

Infraestrutura completa com VM Linux acessível via SSH.

**Conceitos:** data source, file(), módulos conectados, chaves SSH

**Recursos criados:** Resource Group, VNet, Subnets, NSG, Public IP, Network Interface, VM Ubuntu

---

### Lab 06 - Import

Importação de recursos existentes no Azure para o state do Terraform.

**Conceitos:** terraform import, gerenciamento de recursos criados manualmente, aztfexport

**Recursos criados:** Resource Group (criado manualmente e importado)

---

### Lab 07 - Conditional Resources

Criação condicional de recursos usando operador ternário e count.

**Conceitos:** count, operador ternário, recursos opcionais

**Recursos criados:** Resource Group, Public IP (condicional)

---

### Lab 08 - Dynamic Blocks

Geração de blocos repetidos dentro de um recurso.

**Conceitos:** dynamic, content, diferença entre for_each e dynamic

**Recursos criados:** Resource Group, NSG com regras dinâmicas

---

### Lab 09 - Lifecycle Rules

Controle do ciclo de vida dos recursos.

**Conceitos:** prevent_destroy, create_before_destroy, ignore_changes

**Recursos criados:** Resource Groups com diferentes lifecycle rules, Public IP

---

### Lab 10 - Provisioners

Execução de comandos após criar ou destruir recursos.

**Conceitos:** local-exec, remote-exec, null_resource, triggers, when = destroy

**Recursos criados:** Resource Group, null_resource com provisioners

---

## Comandos Úteis

```bash
# Inicializar projeto
terraform init

# Validar sintaxe
terraform validate

# Formatar código
terraform fmt

# Ver plano de execução
terraform plan

# Aplicar mudanças
terraform apply

# Destruir recursos
terraform destroy

# Listar recursos no state
terraform state list

# Importar recurso existente
terraform import <recurso> <id>

# Workspaces
terraform workspace list
terraform workspace new <nome>
terraform workspace select <nome>
```

## Tecnologias

- Terraform >= 1.0.0
- Azure Provider ~> 3.0
- Azure CLI
- Ubuntu 22.04 LTS (VMs)

## Próximos Passos

- [Integração com Ansible para configuração de VMs](https://github.com/crisz-source/ansible)
- [Projeto completo: Terraform + Ansible + Docker](https://github.com/crisz-source/projeto_terraform)

## Referências

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Associate 004 Study Guide](https://developer.hashicorp.com/terraform/tutorials/certification-004)

## Autor

Cristhian

## Licença

Este projeto é para fins de estudo.
