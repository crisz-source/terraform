terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate68dcc151"
    container_name       = "tfstate"
    key                  = "lab-05.tfstate"
  }
}