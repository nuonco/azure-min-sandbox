variable "nuon_id" {
  description = "Nuon Install ID, used as prefix for resource names"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the pre-existing resource group (created by Bicep stack)"
  type        = string
}

variable "vnet_name" {
  description = "Name of the pre-existing VNet (created by Bicep stack)"
  type        = string
}

variable "private_subnet_names" {
  description = "Comma-separated list of private subnet names from the Bicep stack"
  type        = string
}

variable "public_subnet_names" {
  description = "Comma-separated list of public subnet names from the Bicep stack"
  type        = string
}

variable "public_root_domain" {
  description = "Public root domain for DNS zone (e.g. install-id.nuon.run)"
  type        = string
}

variable "internal_root_domain" {
  description = "Internal root domain for private DNS zone"
  type        = string
}

variable "enable_nuon_dns" {
  description = "Whether or not the app should use a nuon-provided nuon.run domain. Controls DNS zone creation."
  type        = string
  default     = "false"
}

variable "tags" {
  description = "List of custom tags to add to the install resources. Used for taxonomic purposes."
  type        = map(any)
  default     = {}
}

variable "additional_tags" {
  description = "Extra tags to append to the default tags that will be added to install resources."
  type        = map(any)
  default     = {}
}
