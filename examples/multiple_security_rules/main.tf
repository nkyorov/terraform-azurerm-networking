module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"

  suffix = ["multiple-security-rules"]
}

#tflint-ignore: all
module "network" {
  source = "../../"

  resource_group_name = module.naming.resource_group.name
  virtual_network = {
    name          = module.naming.virtual_network.name
    address_space = ["10.0.0.0/16"]
    subnets = {
      "my-subnet-1" = {
        address_prefixes = ["10.0.1.0/24"]
        network_security_group = {
          name = "nsg1"
          rules = [
            {
              name                       = "rule1"
              priority                   = 100
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "Tcp"
              source_port_range          = "*"
              destination_port_range     = "80"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            },
            {
              name                       = "rule2"
              priority                   = 200
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "Tcp"
              source_port_range          = "*"
              destination_port_range     = "443"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            }
          ]
        }
      }
    }
  }
  tags = {}
}
