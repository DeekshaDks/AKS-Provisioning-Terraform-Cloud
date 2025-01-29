resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.prefix}-rg"
  location = "East US" # Change to your preferred location
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${var.prefix}-k8s"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                = "defaultpool"
    node_count          = var.node_count
    vm_size             = "Standard_DS2_v2"
    zones               = [1, 2, 3]
    os_disk_size_gb     = 30
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1

    type = "VirtualMachineScaleSets"
    
    tags = {
      "environment"   = "prod"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  role_based_access_control_enabled = true


  tags = {
    Environment = "Dev"
  }

}
