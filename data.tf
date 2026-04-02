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
  enable_nuon_dns = contains(["1", "true"], var.enable_nuon_dns)

  prefix = var.nuon_id

  # Azure does not allow '/' in tag names; replace with '-'
  sanitized_tags = { for k, v in merge(var.tags, var.additional_tags) :
    replace(k, "/", "-") => v
  }

  tags = merge(
    {
      "install.nuon.co-id" = var.nuon_id
    },
    local.sanitized_tags,
  )

  nuon_dns = {
    enabled = local.enable_nuon_dns
    public_domain = {
      zone_id     = local.enable_nuon_dns ? azurerm_dns_zone.public[0].id : ""
      name        = local.enable_nuon_dns ? azurerm_dns_zone.public[0].name : ""
      nameservers = local.enable_nuon_dns ? tolist(azurerm_dns_zone.public[0].name_servers) : tolist([])
    }
    internal_domain = {
      zone_id     = local.enable_nuon_dns ? azurerm_private_dns_zone.internal[0].id : ""
      name        = local.enable_nuon_dns ? azurerm_private_dns_zone.internal[0].name : ""
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
}
