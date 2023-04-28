variable "rg_networking" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network is created."
  type        = string
  default     = "westeurope"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space that is used the virtual network. You can supply more than one address space."
  type        = list(string)
}

variable "subnets" {
  description = "List of objects, representing a single subnet"
  type        = any
  # type = list(object({
  #   name             = string
  #   address_prefixes = list(string)
  #   snet_rules = optional(list(object({
  #     name                       = string
  #     priority                   = number
  #     direction                  = string
  #     access                     = string
  #     protocol                   = string
  #     source_port_range          = string
  #     destination_port_range     = string
  #     source_address_prefix      = string
  #     destination_address_prefix = string
  #   })), null)
  # }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "prefixes" {
  description = "Prefixes for common Azure resources."
  type = object({
    nsg    = optional(string, "NSG")
    subnet = optional(string, "SNET")
  })
  default = {}
}

variable "delimeter" {
  description = "Delimeter used to separate resource names."
  type        = string
  default     = "-"
}