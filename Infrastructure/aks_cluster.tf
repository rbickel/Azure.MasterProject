resource "azurerm_kubernetes_cluster" "rabickelcluster" {
  name                = "rabickelcluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "rabickelcluster"

  default_node_pool {
    name                = "default"
    node_count          = "2"
    vm_size             = "standard_d2_v2"
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_user_assigned_identity" "rabickelclusterid" {
  name                = "${azurerm_kubernetes_cluster.rabickelcluster.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.rabickelcluster.node_resource_group
}

resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = data.azurerm_user_assigned_identity.rabickelclusterid.principal_id
  skip_service_principal_aad_check = true
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.rabickelcluster.kube_config.0.client_certificate
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.rabickelcluster.kube_config_raw
  sensitive = true
}