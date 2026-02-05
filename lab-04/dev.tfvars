location = "brazilsouth"

vnet_address_space = ["10.1.0.0/16"]

subnet_prefixes = {
  subnet-app = "10.1.1.0/24"
  subnet-db  = "10.1.2.0/24"
}

tags_extras = {
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
}