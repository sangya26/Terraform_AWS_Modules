#################################################
#                 VPC
#################################################                   
resource "aws_vpc" "vpc" {
  for_each                             = var.vpc
  cidr_block                           = each.value.cidr_block
  instance_tenancy                     = each.value.instance_tenancy
  enable_dns_hostnames                 = each.value.enable_dns_hostnames
  enable_dns_support                   = each.value.enable_dns_support
  enable_network_address_usage_metrics = each.value.enable_network_address_usage_metrics
  ipv4_ipam_pool_id                    = each.value.ipv4_ipam_pool_id

  # ipv4_netmask_length = each.value.ipv4_netmask_length 

  tags = each.value.tags
}




