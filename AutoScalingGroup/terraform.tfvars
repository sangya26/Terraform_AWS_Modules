
auto_scale = {
  "scaling" = {
    capacity_rebalance        = false
    create_before_destroy     = true
    default_cooldown          = 1
    desired_capacity          = 1
    enabled_metrics           = null
    force_delete              = false
    health_check_grace_period = 1
    health_check_type         = "EC2"
    # launch_template = [{
    #   launch_template_id = "lt-0c232d87aa596f198"
    #   version            = "$Default"
    # }]
    mixed_instances_policy = [{
      instances_distribution = [{
        on_demand_base_capacity                  = 0
        on_demand_percentage_above_base_capacity = 25
        spot_allocation_strategy                 = "capacity-optimized"
      }]
      launch_template_id = "lt-0981c682364214cc4"
      override = [{
        instance_type     = "t2.micro"
        weighted_capacity = "2"
      }]
    }]
    instance_refresh = [{
      preferences = [{
        instance_warmup        = 1
        min_healthy_percentage = 50
      }]
      strategy = "Rolling"
      triggers = null
    }]
    load_balancers          = null #["a23980f7f2ba346cfbd5117459225669"]
    max_instance_lifetime   = 86450
    max_size                = 1
    metrics_granularity     = null
    min_elb_capacity        = null
    min_size                = 1
    name                    = "auto_scale"
    placement_group         = null
    protect_from_scale_in   = false
    service_linked_role_arn = null
    suspended_processes     = null
    tag                     = [{ key = "Name", values = "autoscaleec2" }]
    target_group_arns         = null
    termination_policies      = null
    vpc_zone_identifier       = ["subnet-0c4e24cd1f4837ff3", "subnet-07c852261e5b29e1b"]
    wait_for_capacity_timeout = "10m"
    wait_for_elb_capacity     = null
    # warm_pool = [
    #   {
    #     pool_state                  = null
    #     min_size                    = 0
    #     max_group_prepared_capacity = null

    #     instance_reuse_policy = [{
    #       reuse_on_scale_in = null
    #     }]
    #   }
    # ]

  }
}

