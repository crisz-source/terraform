projeto  = "lab-02-state-remoto"
ambiente = "dev"
location = "brazilsouth"

vnet_address_lab_stateremote = ["10.0.0.0/16"]

subnet_prefixes = {
  subnet-app = "10.0.1.0/24"

}

tags_padrao = {
  projeto      = "lab-02-state-remoto"
  ambiente     = "dev"
  criado_por   = "cristhian"
  centro_custo = "ti-infra"
}
