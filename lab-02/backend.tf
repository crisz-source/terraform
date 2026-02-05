# backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate8c9c8b3a"
    container_name       = "tfstate"
    key                  = "lab-02.tfstate"
  }
}