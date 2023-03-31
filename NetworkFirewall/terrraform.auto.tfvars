firewall-policy-tf = {
  "policy-tf" = {
    name = "firewall-tf-policy"
    # stateful_default_actions = [ "aws:drop_established" ]
    stateful_engine_options = [{
      rule_order = "DEFAULT_ACTION_ORDER"
    }]
    stateful_rule_group_reference = [{
      # priority = 1
      firewall_rule_group_key = "rule-group-tf"
    }]
    # stateless_custom_action = [ {
    #   action_name = "CustomAction"
    #   dimension = [{value = "1"}]
    #   firewall_rule_group_key = "rule-group-tf"

    # } ]
    stateless_default_actions          = ["aws:drop"]
    stateless_fragment_default_actions = ["aws:pass"]
    # stateless_rule_group_reference = [ {
    #   priority = 20
    #   firewall_rule_group_key = "rule-group-tf"
    # } ]
  }
}

firewall-tf = {
  "firewall-tf-13" = {
    delete_protection                 = false
    firewall_policy_key               = "policy-tf"
    firewall_policy_change_protection = false
    name                              = "firewalltf-13"
    subnet_change_protection          = false
    subnet_mapping = [{
      subnet_id = "subnet-07c852261e5b29e1b"
    }]
    tags   = { "key" : "Name", "value" : "policy" }
    vpc_id = "vpc-0e1572b8f8460ab83"
  }
}

firewall-logging-tf = {
  "logging-tf" = {
    firewall_key = "firewall-tf-13"
    logging_configuration = [{
      bucketName           = "robineast1"
      log_destination_type = "S3"
      log_type             = "FLOW"
      prefix               = "/example"
    }]
  }
}

firewall-rule-group = {
  "rule-group-tf" = {
    capacity = "100"
    name     = "rulegroup-tf"
    rule_group = [{
      # ip_sets = [ {
      #   definition = ["10.0.0.0/16", "10.0.1.0/24", "192.168.0.0/16"]
      #   key = "WEBSERVERS_HOSTS"
      # } ]
      # reference_sets = [ {
      #   key = "example"
      #   reference_arn = "aws_ec2_managed_prefix_list.this.arn"
      # } ]
      # rule_option = [ {
      #   keyword = "sid"
      #   settings = ["1"]
      # } ]
      rules_source = [{
        generated_rules_type = "DENYLIST"
        target_types         = ["HTTP_HOST"]
        targets              = ["test.example.com"]
      }]
    }]
    tags = {
      "key" : "Name", "value" : "rulegroup"
    }
    type = "STATEFUL"
  }
}

