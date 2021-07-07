resource "azurerm_kubernetes_cluster" "rabickelcluster" {
  name                = "rabickelcluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "rabickelcluster"
  addon_profile {
    azure_policy {
      enabled = true
    }
  }

  default_node_pool {
    name                = "default"
    node_count          = "2"
    vm_size             = "standard_d2_v2"
    enable_auto_scaling = true
    max_count           = "10"
    min_count           = "2"
  }

  identity {
    type = "SystemAssigned"
  }

  provisioner "local-exec" {
    command = "az aks command -c \"helm repo add ${azurerm_container_registry.acr.name} https://${azurerm_container_registry.acr.name}.azurecr.io && helm repo update\" -g ${azurerm_resource_group.rg.name} -n ${azurerm_kubernetes_cluster.rabickelcluster.name}"
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

output "fqdn" {
  value = azurerm_kubernetes_cluster.rabickelcluster.fqdn
}
output "private_fqdn" {
  value = azurerm_kubernetes_cluster.rabickelcluster.private_fqdn
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.rabickelcluster.kube_config_raw
  sensitive = true
}