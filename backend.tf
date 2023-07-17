terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01595396RG"
    storage_account_name = "tfstaten01595396sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
  }
}
