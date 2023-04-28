<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_resource_group.networking](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delimeter"></a> [delimeter](#input\_delimeter) | Delimeter used to separate resource names. | `string` | `"-"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. | `string` | `"westeurope"` | no |
| <a name="input_prefixes"></a> [prefixes](#input\_prefixes) | Prefixes for common Azure resources. | <pre>object({<br>    nsg    = optional(string, "NSG")<br>    subnet = optional(string, "SNET")<br>  })</pre> | `{}` | no |
| <a name="input_rg_networking"></a> [rg\_networking](#input\_rg\_networking) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of objects, representing a single subnet | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_ids"></a> [nsg\_ids](#output\_nsg\_ids) | A list containing the IDs of all network security groups that were created. |
| <a name="output_nsg_names"></a> [nsg\_names](#output\_nsg\_names) | A list containing the names of all network security groups that were created. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | A list containing the IDs of all subnets that were created. |
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | A list containing the names of all subnets that were created. |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The list of address spaces used by the virtual network. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The virtual network ID. |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location) | The location/region where the virtual network is created. |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the virtual network. |
<!-- END_TF_DOCS -->