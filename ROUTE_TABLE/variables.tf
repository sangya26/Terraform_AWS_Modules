variable "routetable" {
  description = "The route table with their properties."
  type = map(object({
    vpc_id                  = string,
    subnet_association      = optional(list(string), null),
    nat_gateway_association = optional(list(string), null),
    route_args = optional(list(object({
      cidr_block                 = string,
      ipv6_cidr_block            = optional(string, null),
      destination_prefix_list_id = optional(string, null),
      vpc_peering_connection_id  = optional(string, null),
      vpc_endpoint_id            = optional(string, null),
      transit_gateway_id         = optional(string, null),
      network_interface_id       = optional(string, null),
      nat_gateway_id             = optional(string, null),
      local_gateway_id           = optional(string, null),
      gateway_id                 = optional(string, null),
      egress_only_gateway_id     = optional(string, null),
      core_network_arn           = optional(string, null),
      carrier_gateway_id         = optional(string, null)
    })), []),
    tags = optional(map(string))
  }))
  default = {}
}
