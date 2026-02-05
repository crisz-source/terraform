location = "brazilsouth"

vnet_address_space = ["10.2.0.0/16"]

subnet_prefixes = {
  subnet-app = "10.2.1.0/24"
  subnet-db  = "10.2.2.0/24"
}

tags_extras = {
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
}