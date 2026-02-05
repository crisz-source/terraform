terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate4883a16e"
    container_name       = "tfstate"
    key                  = "lab-03.tfstate"
  }
}