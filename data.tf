data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "private" {
  name                 = split(",", var.private_subnet_names)[0]
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

locals {
  prefix = var.nuon_id

  tags = merge(
    {
      "install.nuon.co/id" = var.nuon_id
    },
    var.additional_tags,
  )
}
