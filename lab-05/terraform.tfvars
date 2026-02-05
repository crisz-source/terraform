projeto  = "lab05"
ambiente = "dev"
location = "centralus"

vnet_address_space = ["10.0.0.0/16"]

subnet_prefixes = {
  subnet-app = "10.0.1.0/24"
  subnet-db  = "10.0.2.0/24"
}

vm_size        = "Standard_D2s_v3"
admin_username = "adminuser"

ssh_public_key_path = "~/.ssh/lab05-key.pub"

tags_padrao = {
  projeto      = "lab05-vm"
  ambiente     = "dev"
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
}