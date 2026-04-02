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

variable "workload_profile_type" {
  description = "Workload profile type for the ACA environment"
  type        = string
  default     = "D4"
}

variable "workload_profile_min" {
  description = "Minimum number of workload profile instances"
  type        = number
  default     = 0
}

variable "workload_profile_max" {
  description = "Maximum number of workload profile instances"
  type        = number
  default     = 3
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
