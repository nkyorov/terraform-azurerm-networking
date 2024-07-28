<!-- BEGIN_TF_DOCS -->
# AzureRM Networking Module
This module allows managing resources related to Azure networks:
- Virtual Networks
- Subnets
- Network security groups
- Network security group rules

# Examples
## tfvars
You can set up the variables in `terraform.tfvars` file
```hcl
location            = "westeurope"
resource_group_name = ""
tags                = {}
virtual_network = {
  name          = ""
  address_space = [""]
  subnets = {
    "" = {
      address_prefixes = [""]
      network_security_group = {
        name = ""
        rules = [
          {
            name                       = ""
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "80"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          }
        ]
      }
    }
  }
}
```

## Multiple Security Rules
You can configure multiple NSG rules for one or multiple

```hcl
module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["multiple-security-rules"]
}

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
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | Represents a virtual network. | <pre>object({<br>    name          = string<br>    address_space = list(string)<br>    subnets = map(object({<br>      address_prefixes = list(string)<br>      network_security_group = optional(object({<br>        name = optional(string)<br>        rules = optional(list(object({<br>          name                       = string<br>          priority                   = number<br>          direction                  = string<br>          access                     = string<br>          protocol                   = string<br>          source_port_range          = string<br>          destination_port_range     = string<br>          source_address_prefix      = string<br>          destination_address_prefix = string<br>        })), [])<br>      }), {})<br>    }))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The virtual network ID. |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the virtual network. |
<!-- END_TF_DOCS -->
