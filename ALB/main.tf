#################################
#APPLICATION ELB                #
#################################
resource "aws_lb" "applicaion_load_balancer" {
  for_each           = var.APPLICATION_LB
  name               = each.value.name
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups    = each.value.security_groups
  #subnets                          = each.value.subnets
  drop_invalid_header_fields = each.value.drop_invalid_header_fields
  enable_deletion_protection = each.value.enable_deletion_protection
  customer_owned_ipv4_pool   = each.value.customer_owned_ipv4_pool
  desync_mitigation_mode     = each.value.desync_mitigation_mode
  enable_http2               = each.value.enable_http2
  enable_waf_fail_open       = each.value.enable_waf_fail_open
  idle_timeout               = each.value.idle_timeout
  ip_address_type            = each.value.ip_address_type
  preserve_host_header       = each.value.preserve_host_header
  subnet_mapping {
    subnet_id            = each.value.subnet_mapping1.subnet_id
    allocation_id        = each.value.subnet_mapping1.allocation_id
    ipv6_address         = each.value.subnet_mapping1.ipv6_address
    private_ipv4_address = each.value.subnet_mapping1.private_ipv4_address
  }
  subnet_mapping {
    subnet_id            = each.value.subnet_mapping2.subnet_id
    allocation_id        = each.value.subnet_mapping2.allocation_id
    ipv6_address         = each.value.subnet_mapping2.ipv6_address
    private_ipv4_address = each.value.subnet_mapping2.private_ipv4_address
  }
  access_logs {
    bucket  = each.value.access_logs.bucket
    prefix  = each.value.access_logs.prefix
    enabled = each.value.access_logs.enabled
  }
  tags = each.value.tags
}
