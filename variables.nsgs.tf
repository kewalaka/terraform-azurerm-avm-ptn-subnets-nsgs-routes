variable "network_security_groups" {
  type = map(object({
    name = string
    tags = optional(map(string))
    security_rule = optional(map(object({
      access                                     = string
      description                                = string
      destination_address_prefix                 = string
      destination_address_prefixes               = set(string)
      destination_application_security_group_ids = set(string)
      destination_port_range                     = string
      destination_port_ranges                    = set(string)
      direction                                  = string
      name                                       = string
      priority                                   = number
      protocol                                   = string
      source_address_prefix                      = string
      source_address_prefixes                    = set(string)
      source_application_security_group_ids      = set(string)
      source_port_range                          = string
      source_port_ranges                         = set(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = <<-DESCRIPTION
 - `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.
 - `name` - (Required) Specifies the name of the network security group. Changing this forces a new resource to be created.
 - `resource_group_name` - (Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created.
 - `tags` - (Optional) A mapping of tags to assign to the resource.

 ---
 `security_rule` block supports the following:
 - `access` - (Required) Specifies whether network traffic is allowed or denied. Possible values are `Allow` and `Deny`.
 - `description` - (Optional) A description for this rule. Restricted to 140 characters.
 - `destination_address_prefix` - (Optional) CIDR or destination IP range or * to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `destination_address_prefixes` is not specified.
 - `destination_address_prefixes` - (Optional) List of destination address prefixes. Tags may not be used. This is required if `destination_address_prefix` is not specified.
 - `destination_application_security_group_ids` - (Optional) A List of destination Application Security Group IDs
 - `destination_port_range` - (Optional) Destination Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `destination_port_ranges` is not specified.
 - `destination_port_ranges` - (Optional) List of destination ports or port ranges. This is required if `destination_port_range` is not specified.
 - `direction` - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are `Inbound` and `Outbound`.
 - `name` - (Required) Specifies the name of the network security group. Changing this forces a new resource to be created.
 - `priority` - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
 - `protocol` - (Required) Network protocol this rule applies to. Possible values include `Tcp`, `Udp`, `Icmp`, `Esp`, `Ah` or `*` (which matches all).
 - `source_address_prefix` - (Optional) CIDR or source IP range or * to match any IP. Tags such as `VirtualNetwork`, `AzureLoadBalancer` and `Internet` can also be used. This is required if `source_address_prefixes` is not specified.
 - `source_address_prefixes` - (Optional) List of source address prefixes. Tags may not be used. This is required if `source_address_prefix` is not specified.
 - `source_application_security_group_ids` - (Optional) A List of source Application Security Group IDs
 - `source_port_range` - (Optional) Source Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `source_port_ranges` is not specified.
 - `source_port_ranges` - (Optional) List of source ports or port ranges. This is required if `source_port_range` is not specified.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Network Security Group.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Network Security Group.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Network Security Group.
 - `update` - (Defaults to 30 minutes) Used when updating the Network Security Group.
DESCRIPTION
  default     = {}
  nullable    = false
}
