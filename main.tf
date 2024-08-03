resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "network" {
  name                = var.virtual_network.name
  resource_group_name = azurerm_resource_group.network.name
  location            = azurerm_resource_group.network.location
  address_space       = var.virtual_network.address_space

  tags = var.tags
}


resource "azurerm_subnet" "network" {
  for_each = var.virtual_network.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "network" {
  for_each = {
    for k, v in var.virtual_network.subnets : k => v.network_security_group
    if v.network_security_group != null && v.network_security_group.name != null
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.network.name
  location            = azurerm_resource_group.network.location
}

resource "azurerm_network_security_rule" "network_rule" {
  for_each = {
    for _ in local.subnet_rules : "${_.subnet_name}_${_.rule.name}" => _
  }

  name                        = each.value.rule.name
  priority                    = each.value.rule.priority
  direction                   = each.value.rule.direction
  access                      = each.value.rule.access
  protocol                    = each.value.rule.protocol
  source_port_range           = each.value.rule.source_port_range
  destination_port_range      = each.value.rule.destination_port_range
  source_address_prefix       = each.value.rule.source_address_prefix
  destination_address_prefix  = each.value.rule.destination_address_prefix
  resource_group_name         = azurerm_resource_group.network.name
  network_security_group_name = azurerm_network_security_group.network[each.value.subnet_name].name
}
resource "azurerm_subnet_network_security_group_association" "network" {
  for_each = {
    for k, v in var.virtual_network.subnets : k => v
    if v.network_security_group != null && v.network_security_group.name != null
  }

  subnet_id                 = azurerm_subnet.network[each.key].id
  network_security_group_id = azurerm_network_security_group.network[each.key].id
}
