resource "aws_route_table" "routetable" {
  for_each = var.routetable
  vpc_id   = each.value.vpc_id
  dynamic "route" {#(Optional) A list of route objects. Their keys are documented below. This argument is processed in attribute-as-blocks mode. This means that omitting this argument is interpreted as ignoring any existing routes. To remove all managed routes an empty list should be specified. See the example above.
    for_each = each.value.route_args
    content {
      cidr_block                 = route.value.cidr_block#(Required) The CIDR block of the route.
      ipv6_cidr_block            = route.value.ipv6_cidr_block #(Optional) The Ipv6 CIDR block of the route.
      destination_prefix_list_id = route.value.destination_prefix_list_id #(Optional) The ID of a managed prefix list destination of the route.
      #One of the following target arguments must be supplied
      vpc_peering_connection_id  = route.value.vpc_peering_connection_id#(Optional) Identifier of a VPC peering connection.
      vpc_endpoint_id            = route.value.vpc_endpoint_id#(Optional) Identifier of a VPC Endpoint.
      transit_gateway_id         = route.value.transit_gateway_id#(Optional) Identifier of an EC2 Transit Gateway.
      network_interface_id       = route.value.network_interface_id#(Optional) Identifier of an EC2 network interface.
      nat_gateway_id             = route.value.nat_gateway_id#(Optional) Identifier of a VPC NAT gateway.
      local_gateway_id           = route.value.local_gateway_id#(Optional) Identifier of a Outpost local gateway.
      gateway_id                 = route.value.gateway_id#(Optional) Identifier of a VPC internet gateway or a virtual private gateway.
      egress_only_gateway_id     = route.value.egress_only_gateway_id# (Optional) Identifier of a VPC Egress Only Internet Gateway.
      core_network_arn           = route.value.core_network_arn# (Optional) The Amazon Resource Name (ARN) of a core network.
      carrier_gateway_id         = route.value.carrier_gateway_id#(Optional) Identifier of a carrier gateway. This attribute can only be used when the VPC contains a subnet which is associated with a Wavelength Zone.
    }
  }
  tags  = each.value.tags
}
# locals {
#   route_table_name = { for entry in flatten([ for route_key, route_data in var.routetable : 
#   [
#     for subnet in route_data.subnet_association : {
#       rt_name = route_key
#       vpc_name = route_data.vpc_id
#       subnet-name = "${subnet}"
#     }
#   ] 
#   ]) : "${entry.rt_name}-${entry.subnet-name}" => entry
#   }
# }
# resource "aws_route_table_association" "rt_subnet_association" {
#    for_each = local.route_table_name
#    subnet_id = each.value.subnet-name
#    route_table_id = aws_route_table.routetable[each.value.rt_name].id
# }
locals {
  subnet_route_table_name = { for entry in flatten([ for route_key, route_data in var.routetable : 
  [
    route_data.subnet_association!=null ? 
    [for subnet in route_data.subnet_association : {
      rt_name = route_key
      vpc_name = route_data.vpc_id
      subnet-name = "${subnet}"
      }] : 
      []
  ] 
  ]) : "${entry.rt_name}-${entry.subnet-name}" => entry
  }
  ngw_route_table_name = { for entry in flatten([ for route_key, route_data in var.routetable : 
  [
    route_data.nat_gateway_association!=null ? 
    [for nat_gateway in route_data.nat_gateway_association : {
      rt_name = route_key
      vpc_name = route_data.vpc_id
      ngw-name = "${nat_gateway}"
      }] : 
      []
  ] 
  ]) : "${entry.rt_name}-${entry.ngw-name}" => entry
  }
}
resource "aws_route_table_association" "rt_subnet_association" { #(optional) Please note that one of either subnet_id or gateway_id is required.
   for_each = local.subnet_route_table_name
   subnet_id = each.value.subnet-name
   route_table_id = aws_route_table.routetable[each.value.rt_name].id
}
resource "aws_route_table_association" "rt_ngw_association" { #(optional) Please note that one of either subnet_id or gateway_id is required.
   for_each = local.ngw_route_table_name
   gateway_id = each.value.ngw-name
   route_table_id = aws_route_table.routetable[each.value.rt_name].id
}
