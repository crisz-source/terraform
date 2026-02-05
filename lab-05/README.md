# Lab 05 - Infraestrutura Completa com VM Linux

## Sobre este Lab

Criação de uma infraestrutura completa no Azure com VM Linux acessível via SSH. Junta os conceitos dos labs anteriores (módulos, state remoto) e adiciona novos recursos: Public IP, Network Interface, VM e Data Source.

## O que foi criado

- Resource Group
- Módulo networking: VNet, 2 Subnets, NSG com regras, associações
- Módulo compute: Public IP, Network Interface, VM Linux Ubuntu 22.04
- Conexão SSH com chave pública
 
## Estrutura de Arquivos

```
lab-05-vm/
├── main.tf              # Provider, RG e chamada dos módulos
├── variables.tf         # Variáveis do projeto
├── terraform.tfvars     # Valores
├── locals.tf            # Prefixo, tags e nomes
├── outputs.tf           # IP público, comando SSH
├── backend.tf           # State remoto (lab-05.tfstate)
├── README.md
└── modules/
    ├── networking/
    │   ├── main.tf      # VNet, Subnets, NSG
    │   ├── variables.tf
    │   └── outputs.tf
    └── compute/
        ├── main.tf      # Public IP, NIC, VM
        ├── variables.tf
        └── outputs.tf
```

## Pré-requisitos: Gerar chave SSH

Antes de executar o Terraform, é necessário ter um par de chaves SSH. Se ainda não tiver, gere com o comando:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/lab05-key -N ""
```

Isso cria dois arquivos:

- `~/.ssh/lab05-key` - Chave privada (fica na sua máquina, nunca compartilhe)
- `~/.ssh/lab05-key.pub` - Chave pública (vai pra VM, permite autenticação)

Para verificar que foram criadas:

```bash
ls -la ~/.ssh/lab05-key*
```

## Como os módulos se conectam

O projeto usa dois módulos. O output de um vira input do outro:

```
networking (cria VNet, Subnets, NSG)
    │
    └── subnet_ids["subnet-app"]
            │
            ▼
compute (cria Public IP, NIC, VM)
```

No main.tf do projeto:

```hcl
module "compute" {
  source    = "./modules/compute"
  subnet_id = module.networking.subnet_ids["subnet-app"]
}
```

## Conceitos que aprendi

**Data Source**

O bloco `data` consulta informações que já existem no Azure sem criar nada. Neste lab, usei pra buscar a versão mais recente da imagem do Ubuntu 22.04.

**Função file()**

A função `file()` lê o conteúdo de um arquivo e retorna como string. Usei pra ler a chave pública SSH e passar pro módulo compute.

**Conexão entre módulos**

O output de um módulo pode ser usado como input de outro. O módulo compute recebe o `subnet_id` que veio do módulo networking.

**IDs no Azure**

Todo recurso no Azure recebe um ID único gerado automaticamente. Nunca definimos o ID, apenas referenciamos com `recurso.nome.id`.

## Como executar

```bash
az login
terraform init
terraform plan
terraform apply
```

Após o apply, o output mostra o comando SSH pronto:

```
ssh_command = "ssh -i ~/.ssh/lab05-key adminuser@IP_PUBLICO"
```

Para conectar na VM:

```bash
ssh -i ~/.ssh/lab05-key adminuser@IP_PUBLICO
```
 
Para destruir (importante pra não gastar crédito):

```bash
terraform destroy
```  

## Observações sobre a subscription Azure for Students

A subscription de estudante tem restrições de região e tamanho de VM. Neste lab, a combinação que funcionou foi:

- Região: `centralus`
- Tamanho: `Standard_D2s_v3`

Para descobrir quais tamanhos estão disponíveis na sua subscription:

```bash
az vm list-skus --size Standard_D2s_v3 --output table | grep "None"
```

## Documentação consultada

- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/platform_image
- https://developer.hashicorp.com/terraform/language/data-sources