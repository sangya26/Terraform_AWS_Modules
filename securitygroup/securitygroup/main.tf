data "aws_security_group" "ib_sg" {
  for_each = { for sg in local.ib_security_group_ids_map : sg.key => sg.name }
  name     = each.value
}

data "aws_security_group" "ob_sg" {
  for_each = { for sg in local.ob_security_group_ids_map : sg.value => sg.name }
  name     = each.value
}

locals {
  ib_security_group_ids_map = flatten([
    for k, v in var.security_groups : [
      for rule in coalesce(v.inbound_rules, []) : [
        for sg in coalesce(rule.security_group_names, []) : {
          key  = format("%s_%s_%s", k, rule.from_port, sg)
          name = sg
        }
      ]
    ]
  ])


  ob_security_group_ids_map = flatten([
    for k, v in var.security_groups : [
      for rule in coalesce(v.outbound_rules, []) : [
        for sg in coalesce(rule.security_group_names, []) : {
          key  = format("%s_%s_%s", k, rule.from_port, sg)
          name = sg
        }
      ]
    ]
  ])
}


resource "aws_security_group" "ec2_security_groups" {
  for_each               = var.security_groups
  name                   = each.value["sg_name"]                               
  description            = each.value["description"]                           
  vpc_id                 = each.value["vpc_id"]                                
  dynamic "ingress" { #(Optional) Configuration block for ingress rules. Can be specified multiple times for each ingress rule.
    for_each = each.value.inbound_rules
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_range                                                                                                                                                                             //(Optional) List of CIDR blocks.
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks                                                                                                                                                                      //(Optional) List of IPv6 CIDR blocks.
      prefix_list_ids  = ingress.value.prefix_list_ids                                                                                                                                                                         //(Optional) List of Prefix List IDs.
      security_groups  = ingress.value.security_group_names != null ? [for sg_name in ingress.value.security_group_names : lookup(data.aws_security_group.ib_sg, "${each.key}_${ingress.value.from_port}_${sg_name}").id] : null //(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
      description      = ingress.value.description                                                                                                                                                                             // (Optional) Description of this ingress rule.
      self             = ingress.value.self                                                                                                                                                                                    //(Optional) Whether the security group itself will be added as a source to this ingress rule.
    }
  }
  dynamic "egress" { #(Optional, VPC only) Configuration block for egress rules. Can be specified multiple times for each egress rule.
    for_each = each.value.outbound_rules
    content {
      
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_range                                                                                                                                                                             //(Optional) List of CIDR blocks.
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks                                                                                                                                                                      //(Optional) List of IPv6 CIDR blocks.
      prefix_list_ids  = egress.value.prefix_list_ids                                                                                                                                                                         //(Optional) List of Prefix List IDs.
      security_groups  = egress.value.security_group_names != null ? [for sg_name in egress.value.security_group_names : lookup(data.aws_security_group.ob_sg, "${each.key}_${egress.value.from_port}_${sg_name}").id] : null //(Optional) List of security groups. A group name can be used relative to the default VPC. Otherwise, group ID.
      description      = egress.value.description                                                                                                                                                                             // (Optional) Description of this ingress rule.
      self             = egress.value.self                                                                                                                                                                                  //(Optional) Whether the security group itself will be added as a source to this egress rule.
    }
  }
  tags = var.common_tags #(Optional) Map of tags to assign to the resource.
}
