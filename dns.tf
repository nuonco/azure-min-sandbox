resource "azurerm_dns_zone" "public" {
  count               = local.enable_nuon_dns ? 1 : 0
  name                = var.public_root_domain
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.tags
}

resource "azurerm_private_dns_zone" "internal" {
  name                = var.internal_root_domain
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.tags
}
