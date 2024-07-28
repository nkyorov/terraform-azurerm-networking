variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network is created."
  type        = string
  default     = "westeurope"
}
variable "virtual_network" {
  description = "Represents a virtual network."
  type = object({
    name          = string
    address_space = list(string)
    subnets = map(object({
      address_prefixes = list(string)
      network_security_group = optional(object({
        name = optional(string)
        rules = optional(list(object({
          name                       = string
          priority                   = number
          direction                  = string
          access                     = string
          protocol                   = string
          source_port_range          = string
          destination_port_range     = string
          source_address_prefix      = string
          destination_address_prefix = string
        })), [])
      }), {})
    }))
  })
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  nullable    = true
  default     = {}
}
