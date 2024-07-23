module "subnets" {
  for_each = local.subnets

  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.3.0"

  virtual_network = {
    resource_id = var.virtual_network_resource_id
  }
  name             = each.value.name
  address_prefixes = each.value.address_prefixes
  address_prefix   = each.value.address_prefix

  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, false)
  delegation                                    = try(each.value.delegation, null)
  nat_gateway                                   = try(each.value.nat_gateway, null)
  network_security_group                        = each.value.network_security_group
  private_endpoint_network_policies             = coalesce(each.value.private_endpoint_network_policies, "Enabled")
  private_link_service_network_policies_enabled = coalesce(each.value.private_link_service_network_policies_enabled, true)
  role_assignments                              = try(each.value.role_assignments, {})
  route_table                                   = each.value.route_table
  service_endpoint_policies                     = try(each.value.service_endpoint_policies, null)
  service_endpoints                             = try(each.value.service_endpoints, null)

  depends_on = [
    module.network_security_groups,
    azurerm_route_table.this
  ]
}


module "network_security_groups" {
  for_each = var.network_security_groups

  source              = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version             = "0.2.0"
  resource_group_name = var.resource_group_name
  name                = each.value.name
  security_rules      = try(each.value.security_rules, {})
  location            = var.location
}

# replace with an AVM when available
resource "azurerm_route_table" "this" {
  for_each = var.route_tables

  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  tags                = each.value.tags

  dynamic "route" {
    for_each = try(each.value.routes, {})
    content {
      address_prefix         = route.value.address_prefix
      name                   = route.value.name
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
      next_hop_type          = route.value.next_hop_type
    }
  }
}
