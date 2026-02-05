location = "brazilsouth"

vnet_address_space = ["10.3.0.0/16"]

subnet_prefixes = {
  subnet-app   = "10.3.1.0/24"
  subnet-db    = "10.3.2.0/24"
  subnet-cache = "10.3.3.0/24"
}

tags_extras = {
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
  criticidade  = "alta"
}