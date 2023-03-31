vpc = {
  "vpc001" = {
    cidr_block                           = "196.0.0.0/16" # (Required) The IPv4 CIDR block for the VPC
    instance_tenancy                     = "default"      # (Optional) A tenancy option for instances launched into the VPC.
    enable_dns_hostnames                 = true           #(Optional) A boolean flag to enable/disable DNS support in the VPC
    enable_dns_support                   = true           #(Optional) A boolean flag to enable/disable DNS support in the VPC.
    enable_network_address_usage_metrics = false          #(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC
    ipv4_ipam_pool_id                    = ""             #(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR.
    ipv4_netmask_length                  = null           #(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC.
    tags = {
      # (Optional) A map of tags to assign to the resource.
      Name ="VPC1"
      location = "us-east"
    }
  }
  "vpc002" = {
 cidr_block                           = "196.120.0.0/16" # (Required) The IPv4 CIDR block for the VPC
    instance_tenancy                     = "default"        # (Optional) A tenancy option for instances launched into the VPC.
    enable_dns_hostnames                 = true             #(Optional) A boolean flag to enable/disable DNS support in the VPC
    enable_dns_support                   = true             #(Optional) A boolean flag to enable/disable DNS support in the VPC.
    enable_network_address_usage_metrics = false            #(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC
    ipv4_ipam_pool_id                    = ""               #(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR.
    ipv4_netmask_length                  = null             #(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC.
    tags = {       
           Name ="VPC02"                                   # (Optional) A map of tags to assign to the resource.
      location = "us-east"
    }
  }
}
