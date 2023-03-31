resource "aws_networkfirewall_rule_group" "firewall-rule-group" {
  for_each = var.firewall-rule-group
  capacity = each.value.capacity
  name     = each.value.name
  type     = each.value.type
  dynamic "rule_group" {
    for_each = each.value.rule_group
    content {
      dynamic "rules_source" {
        for_each = rule_group.value.rules_source
        content{
        rules_source_list {
          generated_rules_type = rules_source.value.generated_rules_type
          target_types         = rules_source.value.target_types
          targets              = rules_source.value.targets
        }
        }
      }
      # dynamic "rule_option" {
      #   for_each = rule_group.value.rule_option != null ? rule_group.value.rule_option : []
      #   content {
      #     keyword  = rule_option.value.keyword
      #     settings = rule_option.value.settings
      #   }
      # }
      # dynamic "ip_sets" {
      #   for_each = rule_group.value.ip_sets != null ? rule_group.value.ip_sets : []
      #   content {
      #     key = ip_sets.value.key
      #     ip_set {
      #       definition = ip_sets.value.definition
      #     }
      #   }
      # }
      # dynamic "reference_sets" {
      #   for_each = rule_group.value.reference_sets != null ? rule_group.value.reference_sets : []
      #   content {
      #     ip_set_references {
      #       key = reference_sets.value.key
      #       ip_set_reference {
      #         reference_arn = reference_sets.value.reference_arn
      #       }
      #     }
      #   }

      # }
    }

  }

  tags = each.value.tags
}



resource "aws_networkfirewall_firewall_policy" "firewall-policy-tf" {
  for_each = var.firewall-policy-tf
  name     = each.value.name

  firewall_policy {
    stateful_default_actions           = each.value.stateful_default_actions
    stateless_default_actions          = each.value.stateless_default_actions
    stateless_fragment_default_actions = each.value.stateless_fragment_default_actions

    dynamic "stateless_rule_group_reference" {
      for_each = each.value.stateless_rule_group_reference != null ? each.value.stateless_rule_group_reference : []
      content {
        resource_arn = aws_networkfirewall_rule_group.firewall-rule-group[stateless_rule_group_reference.value.firewall_rule_group_key].arn
        priority     = stateless_rule_group_reference.value.priority
      }
    }

    dynamic "stateful_rule_group_reference" {
      for_each = each.value.stateful_rule_group_reference != null ? each.value.stateful_rule_group_reference : []
      content {
        resource_arn = aws_networkfirewall_rule_group.firewall-rule-group[stateful_rule_group_reference.value.firewall_rule_group_key].arn
        priority     = stateful_rule_group_reference.value.priority
      }
    }

    dynamic "stateful_engine_options" {
      for_each = each.value.stateful_engine_options != null ? each.value.stateful_engine_options : []
      content {
        rule_order = stateful_engine_options.value.rule_order
      }
    }

    dynamic "stateless_custom_action" {
      for_each = each.value.stateless_custom_action != null ? each.value.stateless_custom_action : []
      content {
        action_name = stateless_custom_action.value.action_name
        action_definition {
          publish_metric_action {
            dynamic "dimension" {
              for_each = stateless_custom_action.value.dimension
              content {
                value = dimension.value.value
              }
            }
          }
        }
      }
    }


  }

}

resource "aws_networkfirewall_firewall" "firewall-tf" {
  for_each                          = var.firewall-tf
  name                              = each.value.name
  firewall_policy_arn               = aws_networkfirewall_firewall_policy.firewall-policy-tf[each.value.firewall_policy_key].arn
  vpc_id                            = each.value.vpc_id
  delete_protection                 = each.value.delete_protection
  firewall_policy_change_protection = each.value.firewall_policy_change_protection
  subnet_change_protection          = each.value.subnet_change_protection

  dynamic "subnet_mapping" {
    for_each = each.value.subnet_mapping
    content {
      subnet_id = subnet_mapping.value.subnet_id
    }

  }

  tags = each.value.tags
}

resource "aws_networkfirewall_logging_configuration" "firewall-logging-tf" {
  for_each     = var.firewall-logging-tf
  firewall_arn = aws_networkfirewall_firewall.firewall-tf[each.value.firewall_key].arn
  dynamic "logging_configuration" {
    for_each = each.value.logging_configuration
    content {
      log_destination_config {
        log_destination = {
          bucketName = logging_configuration.value.bucketName
          prefix     = logging_configuration.value.prefix
        }
        log_destination_type = logging_configuration.value.log_destination_type
        log_type             = logging_configuration.value.log_type
      }
    }

  }
}



