
#A comment
resource "azurerm_resource_group" "rg" {
  name     = "rabickel-masteraks"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                    = "rabickelmasteraks"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  sku                     = "Premium"
  admin_enabled           = false
  zone_redundancy_enabled = true
  tags                    = {}
  #disabled geo-replication as it troubled the pipeline and always threw errors on brownfield
  #georeplications         = [{ "location" : "North Europe", "tags" : {}, "zone_redundancy_enabled" : false }, { "location" : "West Europe", "tags" : {}, "zone_redundancy_enabled" : false }]
}
