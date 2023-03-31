##########################
#VARIABLES               #
##########################
variable "APPLICATION_LB" {
  type = map(object({
    name               = string,
    internal           = optional(bool,false)
    load_balancer_type = optional(string,"application")
    security_groups    = optional(list(string),null)
    # subnets                          = list(string),
    drop_invalid_header_fields       = optional(bool,false)
    enable_cross_zone_load_balancing = optional(bool,false)
    enable_deletion_protection       = optional(bool,false)
    customer_owned_ipv4_pool         = optional(string,null)
    desync_mitigation_mode           = optional(string,"defensive")
    enable_http2                     = optional(bool,true)
    enable_waf_fail_open             = optional(bool,false)
    idle_timeout                     = optional(number, "60")
    ip_address_type                  = optional(string,null)
    preserve_host_header             = optional(bool,false)
    subnet_mapping1 = object({
      subnet_id            = string,
      allocation_id        = optional(string,null)
      ipv6_address         = optional(string,null)
      private_ipv4_address = optional(string,null)
    }),
    subnet_mapping2 = object({
      subnet_id            = string,
      allocation_id        = optional(string,null)
      ipv6_address         = optional(string,null)
      private_ipv4_address = optional(string,null)
    }),
    access_logs = object({
      bucket  = string,
      prefix  = optional(string,null)
      enabled = optional(bool,false)
    }),
  tags = map(string) }))
}

