variable "firewall-policy-tf" {
  type = map(object({
    name                               = string    #(Required, Forces new resource) A friendly name of the firewall policy
    stateful_default_actions           = optional(list(string), null)  #(Optional) Set of actions to take on a packet if it does not match any stateful rules in the policy. This can only be specified if the policy has a stateful_engine_options block with a rule_order value of STRICT_ORDER. You can specify one of either or neither values of aws:drop_strict or aws:drop_established, as well as any combination of aws:alert_strict and aws:alert_established
    stateless_default_actions          = list(string)   #(Required) Set of actions to take on a packet if it does not match any of the stateless rules in the policy. You must specify one of the standard actions including: aws:drop, aws:pass, or aws:forward_to_sfe. In addition, you can specify custom actions that are compatible with your standard action choice. If you want non-matching packets to be forwarded for stateful inspection, specify aws:forward_to_sfe.
    stateless_fragment_default_actions = list(string)   #(Required) Set of actions to take on a fragmented packet if it does not match any of the stateless rules in the policy. You must specify one of the standard actions including: aws:drop, aws:pass, or aws:forward_to_sfe. In addition, you can specify custom actions that are compatible with your standard action choice. If you want non-matching packets to be forwarded for stateful inspection, specify aws:forward_to_sfe.

    stateless_rule_group_reference = optional(list(object({   #(Optional) Set of configuration blocks containing references to the stateless rule groups that are used in the policy.
      priority     = optional(number)               #(Required) An integer setting that indicates the order in which to run the stateless rule groups in a single policy. AWS Network Firewall applies each stateless rule group to a packet starting with the group that has the lowest priority setting.
      firewall_rule_group_key = string
    })), null)

    stateful_rule_group_reference = optional(list(object({   #(Optional) Set of configuration blocks containing references to the stateful rule groups that are used in the policy. See Stateful Rule Group Reference below for details.
      priority     = optional(number)   #(Optional) An integer setting that indicates the order in which to apply the stateful rule groups in a single policy. This argument must be specified if the policy has a stateful_engine_options block with a rule_order value of STRICT_ORDER. AWS Network Firewall applies each stateful rule group to a packet starting with the group that has the lowest priority setting.
      firewall_rule_group_key = string
    })), null)

    stateful_engine_options = optional(list(object({   #(Optional) A configuration block that defines options on how the policy handles stateful rules
      rule_order = string    #(Required) Indicates how to manage the order of stateful rule evaluation for the policy. Default value: DEFAULT_ACTION_ORDER. Valid values: DEFAULT_ACTION_ORDER, STRICT_ORDER
    })), null)

    stateless_custom_action = optional(list(object({   #(Optional) Set of configuration blocks describing the custom action definitions that are available for use in the firewall policy's stateless_default_actions
      action_name = string     #(Required, Forces new resource) A friendly name of the custom action.
      dimension = list(object({  #(Required) Set of configuration blocks describing dimension settings to use for Amazon CloudWatch custom metrics
        value       = string  #(Required) The string value to use in the custom metric dimension.
      }))
      
    })), null)

  }))
  
}

variable "firewall-tf" {
  type = map(object({
    name                              = string   #(Required, Forces new resource) A friendly name of the firewall.
    vpc_id                            = string    #(Required, Forces new resource) The unique identifier of the VPC where AWS Network Firewall should create the firewall.
    firewall_policy_key = string
    delete_protection                 = optional(bool, false)  #(Optional) A boolean flag indicating whether it is possible to delete the firewall. Defaults to false
    firewall_policy_change_protection = optional(bool, false)  #(Option) A boolean flag indicating whether it is possible to change the associated firewall policy. Defaults to false
    subnet_change_protection          = optional(bool, false)  #(Optional) A boolean flag indicating whether it is possible to change the associated subnet(s). Defaults to false
    subnet_mapping = list(object({   #(Required) Set of configuration blocks describing the public subnets. Each subnet must belong to a different Availability Zone in the VPC. AWS Network Firewall creates a firewall endpoint in each subnet.
      subnet_id = string
    }))
    tags = map(string)
  }))

}

variable "firewall-logging-tf" {
  type = map(object({
    firewall_key = string
    logging_configuration = list(object({   #(Required) A configuration block describing how AWS Network Firewall performs logging for a firewall
      bucketName           = string   
      prefix               = string
      log_destination_type = string   #(Required) The location to send logs to. Valid values: S3, CloudWatchLogs, KinesisDataFirehose
      log_type             = string   #(Required) The type of log to send. Valid values: ALERT or FLOW. Alert logs report traffic that matches a StatefulRule with an action setting that sends a log message. Flow logs are standard network traffic flow logs.
    }))

  }))
  
}

variable "firewall-rule-group" {
  type = map(object({
    capacity = string  #(Required, Forces new resource) The maximum number of operating resources that this rule group can use. For a stateless rule group, the capacity required is the sum of the capacity requirements of the individual rules. For a stateful rule group, the minimum capacity required is the number of individual rules.
    name     = string  #(Required, Forces new resource) A friendly name of the rule group.
    type     = string  #(Required) Whether the rule group is stateless (containing stateless rules) or stateful (containing stateful rules). Valid values include: STATEFUL or STATELESS
    rule_group = list(object({   #(Optional) A configuration block that defines the rule group rules. Required unless rules is specified
      rules_source = list(object({  #(Required) A configuration block that defines the stateful or stateless rules for the rule group.
        generated_rules_type = string  #(Required) String value to specify whether domains in the target list are allowed or denied access. Valid values: ALLOWLIST, DENYLIST.
        target_types         = list(string) #(Required) Set of types of domain specifications that are provided in the targets argument. Valid values: HTTP_HOST, TLS_SNI
        targets              = list(string) #(Required) Set of domains that you want to inspect for in your traffic flows.
      }))
      rule_option = optional(list(object({
        keyword = string  #(Required) Keyword defined by open source detection systems like Snort or Suricata for stateful rule inspection.
        settings = list(string) #(Optional) Set of strings for additional settings to use in stateful rule inspection.
      })), null)
      ip_sets = optional(list(object({  
        key = string  #(Required) A unique alphanumeric string to identify the ip_set
        definition = list(string) #(Required) Set of IP addresses and address ranges, in CIDR notation.
      })), null)
      reference_sets = optional(list(object({ # A configuration block that defines the IP Set References for the rule group
        key = string
        reference_arn = string
      })),null)
      
    }))
    tags = map(string)
  }))
}

