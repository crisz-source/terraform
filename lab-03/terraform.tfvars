projeto  = "lab03"
ambiente = "dev"
location = "brazilsouth"

vnet_address_space = ["10.0.0.0/16"]

subnet_prefixes = {
  subnet-app = "10.0.1.0/24"
  subnet-db  = "10.0.2.0/24"
}

tags_padrao = {
  projeto      = "lab03-modulos"
  ambiente     = "dev"
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
}