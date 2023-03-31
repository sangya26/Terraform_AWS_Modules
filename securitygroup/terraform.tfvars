security_groups = {
  "sg1" = {
    sg_name     = "pec-bta-db-sg"                                         # Provide desired name for security group
    vpc_id      = "vpc-0486b968c0811d4c4"                                 # Provide VPC ID
    description = "Terraform : Security group for PEC Application Server" # Provide valid security group description.
    inbound_rules = [                                                     #(Optional) Configuration block for ingress rules. Can be specified multiple times for each ingress rule.
      {
        from_port            = "22"                   # Provide required rules from_port range
        to_port              = "22"                   # Provide required rules to_port range
        protocol             = "TCP"                  # Provide required rules protocol
        cidr_range           = []                     #(Optional) List of IPv6 CIDR blocks.
        security_group_names = []                     #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : ssh port" # (Optional) Description of this ingress rule.
        ipv6_cidr_blocks     = []                     #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                     #(Optional) List of Prefix List IDs.
        self                 = false                  #(Optional) Whether the security group itself will be added as a source to this ingress rule.
      },
      {
        from_port            = "3389"
        to_port              = "3389"
        protocol             = "TCP"
        cidr_range           = ["10.70.0.0/25"]       #(Optional) List of IPv6 CIDR blocks.
        security_group_names = []                     #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : RDP port" # (Optional) Description of this ingress rule.
        ipv6_cidr_blocks     = []                     #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                     #(Optional) List of Prefix List IDs.
        self                 = false                  #(Optional) Whether the security group itself will be added as a source to this ingress rule.                                                                                                                             #(Optional) Whether the security group itself will be added as a source to this ingress rule.
      }
    ],
    outbound_rules = [ #(Optional, VPC only) Configuration block for egress rules. Can be specified multiple times for each egress rule.
      {
        from_port            = "22",
        to_port              = "22",
        protocol             = "TCP",
        cidr_range           = ["10.75.0.128/25", "10.75.0.0/25"], #(Optional) List of IPv6 CIDR blocks.
        security_group_names = [],                                 #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : ssh port"              # (Optional) Description of this egress rule.
        ipv6_cidr_blocks     = []                                  #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                                  #(Optional) List of Prefix List IDs.
        self                 = false                               #(Optional) Whether the security group itself will be added as a source to this egress rule.
      },
      {
        from_port            = "3389",
        to_port              = "3389",
        protocol             = "TCP",
        cidr_range           = ["10.199.0.0/25"],     #(Optional) List of IPv6 CIDR blocks.
        security_group_names = [],                    #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : RDP port" # (Optional) Description of this egress rule.
        ipv6_cidr_blocks     = []                     #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                     #(Optional) List of Prefix List IDs.
        self                 = false                  #(Optional) Whether the security group itself will be added as a source to this egress rule.
      }
    ]
  },
  "sg2" = {
    sg_name     = "pec-bta-web-sg"
    vpc_id      = "vpc-0486b968c0811d4c4"
    description = "Terraform : Security group for PEC Application Server"
    inbound_rules = [
      {
        from_port            = "22"
        to_port              = "22"
        protocol             = "TCP"
        cidr_range           = []                     #(Optional) List of IPv6 CIDR blocks.
        security_group_names = []                     #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : ssh port" # (Optional) Description of this egress rule.
        ipv6_cidr_blocks     = []                     #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                     #(Optional) List of Prefix List IDs.
        self                 = false                  #(Optional) Whether the security group itself will be added as a source to this egress rule.
      }
    ],

    outbound_rules = [
      {
        from_port            = "22",
        to_port              = "22",
        protocol             = "TCP",
        cidr_range           = ["10.199.0.128/25", "10.199.0.0/25"], #(Optional) List of IPv6 CIDR blocks.
        security_group_names = [],                                   #(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
        description          = "Terraform : ssh port"                # (Optional) Description of this egress rule.
        ipv6_cidr_blocks     = []                                    #(Optional) List of IPv6 CIDR blocks.
        prefix_list_ids      = []                                    #(Optional) List of Prefix List IDs.
        self                 = false                                 #(Optional) Whether the security group itself will be added as a source to this egress rule.
      }
    ]
  }
}