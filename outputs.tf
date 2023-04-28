output "vnet_address_space" {
  description = "The list of address spaces used by the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

output "vnet_location" {
  description = "The location/region where the virtual network is created."
  value       = azurerm_virtual_network.this.location
}

output "vnet_id" {
  description = "The virtual network ID."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_names" {
  description = "A list containing the names of all subnets that were created."
  value       = [for subnet, data in azurerm_subnet.this : data.name]
}

output "subnet_ids" {
  description = "A list containing the IDs of all subnets that were created."
  value       = [for subnet, data in azurerm_subnet.this : data.id]
}

output "nsg_names" {
  description = "A list containing the names of all network security groups that were created."
  value       = [for nsg, data in azurerm_network_security_group.this : data.name]
}

output "nsg_ids" {
  description = "A list containing the IDs of all network security groups that were created."
  value       = [for nsg, data in azurerm_network_security_group.this : data.id]
}