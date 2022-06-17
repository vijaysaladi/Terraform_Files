provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Vijay_Auto_RG" {
  name     = "Vijay_RG"
  location = var.vm_location
}
