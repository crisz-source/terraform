# Lab 10 - Provisioners

## Sobre este Lab

Uso de provisioners para executar comandos após criar ou destruir recursos. Provisioners permitem rodar scripts locais ou remotos, mas a HashiCorp recomenda evitar quando possível (preferir cloud-init, Ansible ou Packer).

## O que foi feito

- Resource Group com provisioner local-exec na criação e destruição
- null_resource com triggers para reexecutar provisioner quando variável muda

## Estrutura de Arquivos

```
lab-10-provisioner/
├── main.tf           # Provider, RG com provisioners e null_resource
├── variables.tf      # Variáveis
├── terraform.tfvars  # Valores
├── outputs.tf        # Nome do RG e arquivo de log
└── README.md
```

## Conceitos que aprendi

**Tipos de provisioners**

| Tipo | Onde executa | Uso |
|------|--------------|-----|
| local-exec | Na sua máquina | Scripts locais, chamadas de API, logs |
| remote-exec | Dentro do recurso (via SSH) | Instalar pacotes, configurar serviços |
| file | Copia arquivos | Enviar configs, scripts |

**local-exec básico**

Executa comando na máquina onde roda o terraform apply:

```hcl
resource "azurerm_resource_group" "main" {
  name     = "meu-rg"
  location = "centralus"

  provisioner "local-exec" {
    command = "echo 'RG ${self.name} criado' >> provisioner.log"
  }
}
```

- `command` - Comando bash/shell a executar
- `${self.name}` - Referencia o próprio recurso. `self` só funciona dentro de provisioners

**Provisioner no destroy**

Executa apenas quando o recurso está sendo destruído:

```hcl
provisioner "local-exec" {
  when    = destroy
  command = "echo 'RG destruido em ${timestamp()}' >> provisioner.log"
}
```

- `when = destroy` - Executa na destruição, não na criação
- `${timestamp()}` - Função que retorna data/hora atual

**null_resource**

Recurso especial que não cria nada no cloud. Serve apenas para executar provisioners ou criar dependências:

```hcl
resource "null_resource" "exemplo" {
  triggers = {
    ambiente = var.ambiente
  }

  provisioner "local-exec" {
    command = "echo 'Ambiente: ${var.ambiente}' >> provisioner.log"
  }
}
```

- Precisa do provider `hashicorp/null`
- `triggers` - Map que define quando recriar o recurso. Se qualquer valor mudar, o null_resource é destruído e recriado (executando os provisioners novamente)

## Fluxo de execução

```
terraform apply (primeira vez)
    ├── Cria null_resource.exemplo
    │       └── Executa provisioner: "Ambiente: dev"
    └── Cria azurerm_resource_group.main
            └── Executa provisioner: "RG criado em centralus"

terraform apply (ambiente mudou de dev pra prod)
    └── Recria null_resource.exemplo (trigger mudou)
            └── Executa provisioner: "Ambiente: prod"

terraform destroy
    ├── Destrói null_resource.exemplo
    └── Destrói azurerm_resource_group.main
            └── Executa provisioner: "RG destruido em ..."
```

## Resultado dos testes

Arquivo provisioner.log após todo o ciclo:

```
Ambiente: dev - Executado em: 2026-02-06T14:39:03Z
Resource Group lab10-provisioner-rg criado em centralus
Ambiente: prod - Executado em: 2026-02-06T14:45:13Z
Resource Group destruido em 2026-02-06T14:50:35Z
```

## Por que evitar provisioners?

A HashiCorp recomenda alternativas:

| Alternativa | Quando usar |
|-------------|-------------|
| cloud-init | Script no boot da VM (mais confiável) |
| Ansible | Configuração de servidores (mais poderoso) |
| Packer | Criar imagens pré-configuradas |

Provisioners têm problemas:
- Não são declarativos (difícil saber o estado atual)
- Falhas podem deixar infra em estado inconsistente
- Difícil de testar e debugar

Use provisioners apenas para casos simples ou quando não há alternativa.

## Documentação consultada

- https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
- https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec
- https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
- https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource