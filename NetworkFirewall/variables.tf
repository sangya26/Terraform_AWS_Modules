variable "firewall-policy-tf" {
  type = map(object({
    name                               = string
    stateful_default_actions           = optional(list(string), null)
    stateless_default_actions          = list(string)
    stateless_fragment_default_actions = list(string)

    stateless_rule_group_reference = optional(list(object({
      priority                = optional(number)
      firewall_rule_group_key = string
    })), null)

    stateful_rule_group_reference = optional(list(object({
      priority                = optional(number)
      firewall_rule_group_key = string
    })), null)

    stateful_engine_options = optional(list(object({
      rule_order = string
    })), null)

    stateless_custom_action = optional(list(object({
      action_name = string
      dimension = list(object({
        value = string
      }))

    })), null)

  }))

}

variable "firewall-tf" {
  type = map(object({
    name                              = string
    vpc_id                            = string
    firewall_policy_key               = string
    delete_protection                 = optional(bool, false)
    firewall_policy_change_protection = optional(bool, false)
    subnet_change_protection          = optional(bool, false)
    subnet_mapping = list(object({
      subnet_id = string
    }))
    tags = map(string)
  }))

}

variable "firewall-logging-tf" {
  type = map(object({
    firewall_key = string
    logging_configuration = list(object({
      bucketName           = string
      prefix               = string
      log_destination_type = string
      log_type             = string
    }))

  }))

}

variable "firewall-rule-group" {
  type = map(object({
    capacity = string
    name     = string
    type     = string
    rule_group = list(object({
      rules_source = list(object({
        generated_rules_type = string
        target_types         = list(string)
        targets              = list(string)
      }))
      rule_option = optional(list(object({
        keyword  = string
        settings = list(string)
      })), null)
      ip_sets = optional(list(object({
        key        = string
        definition = list(string)
      })), null)
      reference_sets = optional(list(object({
        key           = string
        reference_arn = string
      })), null)

    }))
    tags = map(string)
  }))
}

