routetable = {
  "route_table1" = {
    vpc_id             = "vpc-0e1572b8f8460ab83"
    subnet_association = ["subnet-0c4e24cd1f4837ff3"] #(optional) Please note that one of either subnet_id or gateway_id is required.
    route = [{                                   #(Optional) A list of route objects. Their keys are documented below. This argument is processed in attribute-as-blocks mode. This means that omitting this argument is interpreted as ignoring any existing routes. To remove all managed routes an empty list should be specified. See the example above.
      cidr_block                 = "10.0.1.0/24" #(Required) The CIDR block of the route.
      ipv6_cidr_block            = null          #(Optional) The Ipv6 CIDR block of the route.
      destination_prefix_list_id = null          #(Optional) The ID of a managed prefix list destination of the route.
      #One of the following target arguments must be supplied
      vpc_peering_connection_id = null #(Optional) Identifier of a VPC peering connection.
      vpc_endpoint_id           = null #(Optional) Identifier of a VPC Endpoint.
      transit_gateway_id        = null #(Optional) Identifier of an EC2 Transit Gateway.
      network_interface_id      = null #(Optional) Identifier of an EC2 network interface.
      nat_gateway_id            = null #(Optional) Identifier of a VPC NAT gateway.
      local_gateway_id          = null #(Optional) Identifier of a Outpost local gateway.
      gateway_id                = null #(Optional) Identifier of a VPC internet gateway or a virtual private gateway.
      egress_only_gateway_id    = null # (Optional) Identifier of a VPC Egress Only Internet Gateway.
      core_network_arn          = null # (Optional) The Amazon Resource Name (ARN) of a core network.
      carrier_gateway_id        = null #(Optional) Identifier of a carrier gateway. This attribute can only be used when the VPC contains a subnet which is associated with a Wavelength Zone.

    }]
    tags = {
      Name = "route_table1"
    }
  },
  "route_table2" = {
    vpc_id                  = "vpc-0e1572b8f8460ab83"
    nat_gateway_association = ["igw-048d59f131087d97d"] #(optional) Please note that one of either subnet_id or gateway_id is required.
    tags = {
      Name = "route_table2"
    }
  }
}