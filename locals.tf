locals {
  subnet_rules = flatten([
    for subnet_name, subnet in var.virtual_network.subnets : [
      for rule in subnet.network_security_group.rules : {
        subnet_name = subnet_name
        rule        = rule
      }
    ]
  ])
}
