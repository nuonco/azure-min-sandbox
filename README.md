# Nuon Azure Min Sandbox

This is a baseline sandbox that provides a bare minimum Azure environment for use with Nuon.

It provisions an Azure Container Registry and (optionally) public/private DNS zones,
on top of a pre-existing resource group, virtual network, and subnets created by an
upstream Bicep stack.

See the [example-app-configs](https://github.com/nuonco/example-app-configs) repository
for more information and other app configs.

## Requirements

| Name                                                                     | Version    |
| ------------------------------------------------------------------------ | ---------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.11.3  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 4.34.0  |

## Providers

| Name                                                         | Version    |
| ------------------------------------------------------------ | ---------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | ~> 4.34.0  |

## Resources

| Name                                                                                                                                         | Type        |
| -------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)         | resource    |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone)                          | resource    |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)        | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)            | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)               | data source |
| [azurerm_virtual_network.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network)       | data source |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet)                          | data source |

The `azurerm_dns_zone.public` and `azurerm_private_dns_zone.internal` resources are
only created when `enable_nuon_dns` is `"true"` or `"1"`.

## Inputs

| Name                                                                                              | Description                                                                                          | Type          | Default     | Required |
| ------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------- | ----------- | :------: |
| <a name="input_nuon_id"></a> [nuon_id](#input_nuon_id)                                            | Nuon Install ID, used as prefix for resource names                                                   | `string`      | n/a         |   yes    |
| <a name="input_location"></a> [location](#input_location)                                         | Azure region for all resources                                                                       | `string`      | n/a         |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)        | Name of the pre-existing resource group (created by Bicep stack)                                     | `string`      | n/a         |   yes    |
| <a name="input_vnet_name"></a> [vnet_name](#input_vnet_name)                                      | Name of the pre-existing VNet (created by Bicep stack)                                               | `string`      | n/a         |   yes    |
| <a name="input_private_subnet_names"></a> [private_subnet_names](#input_private_subnet_names)     | Comma-separated list of private subnet names from the Bicep stack                                    | `string`      | n/a         |   yes    |
| <a name="input_public_subnet_names"></a> [public_subnet_names](#input_public_subnet_names)        | Comma-separated list of public subnet names from the Bicep stack                                     | `string`      | n/a         |   yes    |
| <a name="input_public_root_domain"></a> [public_root_domain](#input_public_root_domain)           | Public root domain for DNS zone (e.g. install-id.nuon.run). Only used when `enable_nuon_dns` is set. | `string`      | `""`        |    no    |
| <a name="input_internal_root_domain"></a> [internal_root_domain](#input_internal_root_domain)     | Internal root domain for private DNS zone. Only used when `enable_nuon_dns` is set.                  | `string`      | `""`        |    no    |
| <a name="input_enable_nuon_dns"></a> [enable_nuon_dns](#input_enable_nuon_dns)                    | Whether the app should use a Nuon-provided nuon.run domain. Controls DNS zone creation.              | `string`      | `"false"`   |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                     | Custom tags to add to install resources. Used for taxonomic purposes.                                | `map(any)`    | `{}`        |    no    |
| <a name="input_additional_tags"></a> [additional_tags](#input_additional_tags)                    | Extra tags to append to the default tags that will be added to install resources.                    | `map(any)`    | `{}`        |    no    |

## Outputs

| Name                                                                                | Description                                                                                                |
| ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| <a name="output_vnet"></a> [vnet](#output_vnet)                                     | A map of vnet attributes: id, name, subnet_ids.                                                            |
| <a name="output_public_domain"></a> [public_domain](#output_public_domain)          | A map of public domain attributes: nameservers, name, id.                                                  |
| <a name="output_internal_domain"></a> [internal_domain](#output_internal_domain)    | A map of internal domain attributes: nameservers, name, id.                                                |
| <a name="output_nuon_dns"></a> [nuon_dns](#output_nuon_dns)                         | A map of Nuon DNS attributes matching the structure expected by the ctl-api ProvisionDNS workflow.         |
| <a name="output_account"></a> [account](#output_account)                            | A map of Azure account attributes: location, subscription_id, client_id, resource_group_name.              |
| <a name="output_acr"></a> [acr](#output_acr)                                        | A map of ACR attributes: id, name, login_server.                                                           |
