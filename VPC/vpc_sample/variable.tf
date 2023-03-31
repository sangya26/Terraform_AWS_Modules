variable "vpc" {

  type = map(object({
    cidr_block                           = string
    instance_tenancy                     = optional(string, "default")
    enable_dns_hostnames                 = optional(bool, true)
    enable_dns_support                   = optional(bool, true)
    enable_network_address_usage_metrics = optional(bool, false)
    ipv4_ipam_pool_id                    = optional(string, null)
    # ipv4_netmask_length                  = optional(string,null)
    tags = map(string)
  }))
}