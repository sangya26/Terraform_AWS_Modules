subnet = {
  "public_subnet" = {
    availability_zone                              = "us-east-1a"                      # AZ for the subnet
    cidr_block                                     = "196.0.2.0/24"                    #The IPv4 CIDR block for the subnet.    
    enable_dns64                                   = false,  #(Optional) Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. Default: false
    enable_resource_name_dns_aaaa_record_on_launch = false,  #(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. Default: false
    enable_resource_name_dns_a_record_on_launch    = false,  # (Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. Default: false
    assign_ipv6_address_on_creation                = false,  #(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false
    ipv6_native                                    = false,  #(Optional) Indicates whether to create an IPv6-only subnet. Default: false
    #  ipv6_cidr_block                                 = "",
    customer_owned_ipv4_pool        = "",                    #(Optional) The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured.
    map_customer_owned_ip_on_launch = false,                 #(Optional) Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false
    outpost_arn                     = "",                    #(Optional) The Amazon Resource Name (ARN) of the Outpost.
    map_public_ip_on_launch         = false                  #(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false

    tags = {                                                  #A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level
      Name     = "pub-subnet"
      location = "us-east-1"
    }
  }
  "private_subnet" = {
    availability_zone                              = "us-east-1b"
    cidr_block                                     = "196.0.20.0/24"
    enable_dns64                                   = false,
    enable_resource_name_dns_aaaa_record_on_launch = false,
    enable_resource_name_dns_a_record_on_launch    = false,
    assign_ipv6_address_on_creation                = false,
    ipv6_native                                    = false,
    #  ipv6_cidr_block                                 = "",
    customer_owned_ipv4_pool        = "",
    map_customer_owned_ip_on_launch = false,
    outpost_arn                     = "",
    map_public_ip_on_launch         = false

    tags = {
      Name     = "pri-subnet"
      location = "us-east-1"
    }
  }
}

region = "us-east-1"
vpc_id = "vpc-01e90865f285f7c06"

