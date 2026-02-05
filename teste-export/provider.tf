provider "azurerm" {
  features {
  }
  subscription_id                 = "67e35d63-a466-4f40-bfb9-c5ecfcb0da62"
  environment                     = "public"
  use_msi                         = false
  use_cli                         = true
  use_oidc                        = false
  resource_provider_registrations = "none"
}
