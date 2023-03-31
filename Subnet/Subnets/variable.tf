variable "subnet" {
  type = map(
    object(
      {
        tags                                           = map(string),
        availability_zone                              = optional(string, null)
        cidr_block                                     = string,
        enable_dns64                                   = optional(bool, false),
        enable_resource_name_dns_aaaa_record_on_launch = optional(bool, false),
        enable_resource_name_dns_a_record_on_launch    = optional(bool, false),
        assign_ipv6_address_on_creation                = optional(bool, false),
        #CIDR_range_subnet_ipv6                          = string,
        ipv6_native                     = optional(bool, false),
        customer_owned_ipv4_pool        = optional(string, null),
        map_customer_owned_ip_on_launch = optional(bool, false),
        outpost_arn                     = optional(string, null),
        map_public_ip_on_launch         = optional(bool, false)
      }
  ))
}

variable "region" {
  type = string
}
variable "vpc_id" {
  type = string
}