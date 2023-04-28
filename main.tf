resource "azurerm_resource_group" "networking" {
  name     = var.rg_networking
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.networking.name
  location            = azurerm_resource_group.networking.location
  address_space       = var.vnet_address_space

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = "${var.prefixes.subnet}${var.delimeter}${each.key}"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "this" {
  for_each = var.subnets

  name                = "${var.prefixes.nsg}${var.delimeter}${each.key}"
  resource_group_name = azurerm_resource_group.networking.name
  location            = azurerm_resource_group.networking.location

  tags = var.tags
}

locals {
  nsg_rules = flatten([for subnet, details in var.subnets :
    flatten([for nsg_rule in details.nsg_rules :
      {
        "nsg_name"                   = "${var.prefixes.nsg}${var.delimeter}${subnet}"
        "name"                       = nsg_rule.name,
        "priority"                   = nsg_rule.priority,
        "direction"                  = nsg_rule.direction,
        "access"                     = nsg_rule.access,
        "protocol"                   = nsg_rule.protocol
        "source_port_range"          = nsg_rule.source_port_range
        "destination_port_range"     = nsg_rule.destination_port_range
        "source_address_prefix"      = nsg_rule.source_address_prefix
        "destination_address_prefix" = nsg_rule.destination_address_prefix
      }
    ])
  ])
}

resource "azurerm_network_security_rule" "this" {
  for_each = { for _, rule in local.nsg_rules : _ => rule }

  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = each.value.nsg_name

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix

  depends_on = [
    azurerm_network_security_group.this
  ]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}