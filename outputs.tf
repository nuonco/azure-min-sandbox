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
    nameservers = azurerm_dns_zone.public.name_servers
    name        = azurerm_dns_zone.public.name
    id          = azurerm_dns_zone.public.id
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
  value = {
    enabled = true
    public_domain = {
      zone_id     = azurerm_dns_zone.public.id
      name        = azurerm_dns_zone.public.name
      nameservers = tolist(azurerm_dns_zone.public.name_servers)
    }
    internal_domain = {
      zone_id     = azurerm_private_dns_zone.internal.id
      name        = azurerm_private_dns_zone.internal.name
      nameservers = tolist([])
    }
    alb_ingress_controller = {
      enabled  = false
      id       = ""
      chart    = ""
      revision = ""
    }
    external_dns = {
      enabled  = false
      id       = ""
      chart    = ""
      revision = ""
    }
    cert_manager = {
      enabled  = false
      id       = ""
      chart    = ""
      revision = ""
    }
    ingress_nginx = {
      enabled  = false
      id       = ""
      chart    = ""
      revision = ""
    }
  }
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

output "aca_environment" {
  value = {
    id                          = azurerm_container_app_environment.aca.id
    name                        = azurerm_container_app_environment.aca.name
    default_domain              = azurerm_container_app_environment.aca.default_domain
    static_ip_address           = azurerm_container_app_environment.aca.static_ip_address
    location                    = var.location
    log_analytics_workspace_id  = azurerm_log_analytics_workspace.aca.id
  }
  description = "A map of ACA environment attributes: id, name, default_domain, static_ip_address, location."
}
