
#A comment
resource "azurerm_resource_group" "rg" {
  name     = "rabickel-masteraks"
  location = "West Europe"
}


resource "azurerm_container_registry" "acr" {
  name                     = "rabickel-masteraks"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["North Europe", "West Europe"]
}
