
resource "aws_autoscaling_group" "auto_scale" {
  for_each = var.auto_scale

  name                      = each.value.name
  vpc_zone_identifier       = each.value.vpc_zone_identifier
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  load_balancers            = each.value.load_balancers
  health_check_grace_period = each.value.health_check_grace_period
  health_check_type         = each.value.health_check_type
  min_elb_capacity          = each.value.min_elb_capacity
  wait_for_elb_capacity     = each.value.wait_for_elb_capacity
  target_group_arns         = each.value.target_group_arns
  default_cooldown          = each.value.default_cooldown
  force_delete              = each.value.force_delete
  termination_policies      = each.value.termination_policies
  suspended_processes       = each.value.suspended_processes
  placement_group           = each.value.placement_group
  enabled_metrics           = each.value.enabled_metrics
  metrics_granularity       = each.value.metrics_granularity
  wait_for_capacity_timeout = each.value.wait_for_capacity_timeout
  protect_from_scale_in     = each.value.protect_from_scale_in
  service_linked_role_arn   = each.value.service_linked_role_arn
  desired_capacity          = each.value.desired_capacity
  max_instance_lifetime     = each.value.max_instance_lifetime
  capacity_rebalance        = each.value.capacity_rebalance

  dynamic "instance_refresh" {
    for_each = each.value.instance_refresh

    content {
      strategy = instance_refresh.value.strategy
      dynamic "preferences" {
        for_each = instance_refresh.value.preferences
        content {
          instance_warmup        = preferences.value.instance_warmup
          min_healthy_percentage = preferences.value.min_healthy_percentage
        }
      }
      triggers = instance_refresh.value.triggers
    }
  }

  # dynamic "launch_template" {
  #   for_each = each.value.launch_template
  #   content {
  #     id      = launch_template.value.launch_template_id
  #     version = launch_template.value.version
  #   }

  # }

  dynamic "mixed_instances_policy" {
    for_each = each.value.mixed_instances_policy
    content {
      dynamic "instances_distribution" {
        for_each = try([mixed_instances_policy.value.instances_distribution], [])
        content {
          on_demand_base_capacity                  = try(instances_distribution.value.on_demand_base_capacity, null)
          on_demand_percentage_above_base_capacity = try(instances_distribution.value.on_demand_percentage_above_base_capacity, null)
          spot_allocation_strategy                 = try(instances_distribution.value.spot_allocation_strategy, null)
        }
      }

      launch_template {
        launch_template_specification {
          launch_template_id = mixed_instances_policy.value.launch_template_id
        }

        dynamic "override" {
          for_each = try(mixed_instances_policy.value.override, [])

          content {
            instance_type = try(override.value.instance_type, null)
            weighted_capacity = try(override.value.weighted_capacity, null)
          }
        }
      }
    }
  }

#   dynamic "warm_pool" {
#     for_each = each.value.warm_pool
#     content {
#       pool_state                  = try(warm_pool.pool_state, null)
#       min_size                    = try(warm_pool.min_size, null)
#       max_group_prepared_capacity = try(warm_pool.max_group_prepared_capacity, null)
#       dynamic "instance_reuse_policy" {
#         for_each = warm_pool.value.instance_reuse_policy
#         content {
#           reuse_on_scale_in = instance_reuse_policy.value.reuse_on_scale_in
#         }
#       }
#     }
#   }

  dynamic "tag" {
    for_each = each.value.tag
    content{
      key = tag.value.key
      value = tag.value.values
      propagate_at_launch = true
    }
  }


  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}