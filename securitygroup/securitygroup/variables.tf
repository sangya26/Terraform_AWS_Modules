variable "security_groups" {
  description = "The network security groups with their properties."
  type = map(object({
    sg_name     = string,
    description = string,
    vpc_id      = string,
    inbound_rules = optional(list(object({
      to_port          = string,
      from_port        = string,
      protocol         = string,
       description      = optional(string,null),
      cidr_range       = optional(list(string),null),
      ipv6_cidr_blocks = optional(list(string),null),
      prefix_list_ids  = optional(list(string),null),
      self=optional(bool,false),
    security_group_names = optional(list(string),null) })),[]),
    outbound_rules = optional(list(object({
      to_port          = string,
      from_port        = string,
      protocol         = string,
       description      = optional(string,null),
      cidr_range       = optional(list(string),null),
      ipv6_cidr_blocks = optional(list(string),null),
      prefix_list_ids  = optional(list(string),null),
      self=optional(bool,false),
    security_group_names = optional(list(string),null) })),[]),
  }))
  default = {}
}


variable "ib_security_group_ids_map" {
  type        = map(string)
  description = "Specifies the Map of Security Group Id's"
  default     = {}
}

variable "ob_security_group_ids_map" {
  type        = map(string)
  description = "Specifies the Map of Security Group Id's"
  default     = {}
}

variable "common_tags" {
  default = {}
}