################################
##     Data block for VPC ID  ##
################################
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

###############################


resource "aws_subnet" "subnet" {
  for_each          = var.subnet
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags

  enable_dns64                                   = each.value.enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = each.value.enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = each.value.enable_resource_name_dns_a_record_on_launch


  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  #ipv6_cidr_block                 = lookup(subnet.value, "CIDR_range_subnet_ipv6", null) 
  ipv6_native = each.value.ipv6_native

  customer_owned_ipv4_pool        = each.value.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = each.value.map_customer_owned_ip_on_launch
  outpost_arn                     = each.value.outpost_arn

  map_public_ip_on_launch = each.value.map_public_ip_on_launch

}


