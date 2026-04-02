output "vnet" {
  value = {
    id         = data.azurerm_virtual_network.existing.id
    name       = data.azurerm_virtual_network.existing.name
    subnet_ids = [data.azurerm_subnet.private.id]
  }
  description = "A map of vnet attributes: id, name, subnet_ids."
}

output "public_domain" {
  value = {
    nameservers = local.enable_nuon_dns ? azurerm_dns_zone.public[0].name_servers : []
    name        = local.enable_nuon_dns ? azurerm_dns_zone.public[0].name : ""
    id          = local.enable_nuon_dns ? azurerm_dns_zone.public[0].id : ""
  }
  description = "A map of public domain attributes: nameservers, name, id."
}

output "internal_domain" {
  value = {
    nameservers = []
    name        = azurerm_private_dns_zone.internal.name
    id          = azurerm_private_dns_zone.internal.id
  }
  description = "A map of internal domain attributes: nameservers, name, id."
}

output "nuon_dns" {
  value       = local.nuon_dns
  description = "A map of Nuon DNS attributes matching the structure expected by ctl-api ProvisionDNS workflow."
}

output "account" {
  value = {
    location            = var.location
    subscription_id     = data.azurerm_client_config.current.subscription_id
    client_id           = data.azurerm_client_config.current.client_id
    resource_group_name = data.azurerm_resource_group.rg.name
  }
  description = "A map of Azure account attributes: location, subscription_id, client_id, resource_group_name."
}

output "acr" {
  value = {
    id           = azurerm_container_registry.acr.id
    name         = azurerm_container_registry.acr.name
    login_server = azurerm_container_registry.acr.login_server
  }
  description = "A map of ACR attributes: id, name, login_server."
}
