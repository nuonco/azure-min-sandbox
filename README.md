# Nuon Azure Min Sandbox

This is a baseline sandbox that provides a bare minimum Azure environment for use with Nuon.

It provisions an Azure Container Apps environment, Container Registry, and DNS zones —
the foundational infrastructure needed for deploying containerized applications.

See the [example-app-configs](https://github.com/nuonco/example-app-configs) repository
for more information and other app configs.

## Requirements

| Name                                                                           | Version    |
| ------------------------------------------------------------------------------ | ---------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)       | >= 1.11.3  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)             | ~> 4.34.0  |

## Providers

| Name                                                       | Version    |
| ---------------------------------------------------------- | ---------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | ~> 4.34.0  |

## Resources

| Name                                                                                                                                                                                          | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_container_app_environment.aca](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment)                                             | resource    |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)                                                           | resource    |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone)                                                                            | resource    |
| [azurerm_log_analytics_workspace.aca](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace)                                                 | resource    |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)                                                          | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)                                                              | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                                                                 | data source |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet)                                                                           | data source |
| [azurerm_virtual_network.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network)                                                         | data source |

## Inputs

| Name                                                                                                                  | Description                                                           | Type          | Default          | Required |
| --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------- | ---------------- | :------: |
| <a name="input_nuon_id"></a> [nuon_id](#input_nuon_id)                                                               | Nuon Install ID, used as prefix for resource names                    | `string`      | n/a              |   yes    |
| <a name="input_location"></a> [location](#input_location)                                                             | Azure region for all resources                                        | `string`      | n/a              |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)                            | Name of the pre-existing resource group (created by Bicep stack)      | `string`      | n/a              |   yes    |
| <a name="input_vnet_name"></a> [vnet_name](#input_vnet_name)                                                          | Name of the pre-existing VNet (created by Bicep stack)                | `string`      | n/a              |   yes    |
| <a name="input_private_subnet_names"></a> [private_subnet_names](#input_private_subnet_names)                         | Comma-separated list of private subnet names from the Bicep stack     | `string`      | n/a              |   yes    |
| <a name="input_public_subnet_names"></a> [public_subnet_names](#input_public_subnet_names)                            | Comma-separated list of public subnet names from the Bicep stack      | `string`      | n/a              |   yes    |
| <a name="input_public_root_domain"></a> [public_root_domain](#input_public_root_domain)                               | Public root domain for DNS zone                                       | `string`      | n/a              |   yes    |
| <a name="input_internal_root_domain"></a> [internal_root_domain](#input_internal_root_domain)                         | Internal root domain for private DNS zone                             | `string`      | n/a              |   yes    |
| <a name="input_workload_profile_type"></a> [workload_profile_type](#input_workload_profile_type)                      | Workload profile type for the ACA environment                         | `string`      | `"D4"`           |    no    |
| <a name="input_workload_profile_min"></a> [workload_profile_min](#input_workload_profile_min)                         | Minimum number of workload profile instances                          | `number`      | `0`              |    no    |
| <a name="input_workload_profile_max"></a> [workload_profile_max](#input_workload_profile_max)                         | Maximum number of workload profile instances                          | `number`      | `3`              |    no    |
| <a name="input_additional_tags"></a> [additional_tags](#input_additional_tags)                                         | Additional tags to apply to all resources                             | `map(string)` | `{}`             |    no    |

## Outputs

| Name                                                                                | Description                                                                                               |
| ----------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| <a name="output_vnet"></a> [vnet](#output_vnet)                                     | A map of vnet attributes: id, name, subnet_ids.                                                           |
| <a name="output_public_domain"></a> [public_domain](#output_public_domain)          | A map of public domain attributes: nameservers, name, id.                                                 |
| <a name="output_internal_domain"></a> [internal_domain](#output_internal_domain)    | A map of internal domain attributes: nameservers, name, id.                                               |
| <a name="output_nuon_dns"></a> [nuon_dns](#output_nuon_dns)                         | A map of Nuon DNS attributes matching the structure expected by ctl-api ProvisionDNS workflow.             |
| <a name="output_account"></a> [account](#output_account)                            | A map of Azure account attributes: location, subscription_id, client_id, resource_group_name.             |
| <a name="output_acr"></a> [acr](#output_acr)                                        | A map of ACR attributes: id, name, login_server.                                                          |
| <a name="output_aca_environment"></a> [aca_environment](#output_aca_environment)    | A map of ACA environment attributes: id, name, default_domain, static_ip_address, location.               |
