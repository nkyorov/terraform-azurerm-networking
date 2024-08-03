output "vnet_id" {
  description = "The virtual network ID."
  value       = azurerm_virtual_network.network.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.network.name
}
