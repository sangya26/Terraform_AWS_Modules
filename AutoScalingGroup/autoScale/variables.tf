
variable "auto_scale" {
  type = map(object({
    name                      = string                              #(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name    
    vpc_zone_identifier       = list(string)                        #(Optional) List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with availability_zones
    max_size                  = number                              #(Required) Maximum size of the Auto Scaling Group
    min_size                  = number                              #(Required) Minimum size of the Auto Scaling Group. 
    load_balancers            = optional(list(string), null)        #(Optional) List of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target_group_arns instead
    health_check_grace_period = optional(number, 300)               #(Optional, Default: 300) Time (in seconds) after instance comes into service before checking health.
    health_check_type         = optional(string, "EC2")             #(Optional) "EC2" or "ELB". Controls how health checking is done.
    min_elb_capacity          = optional(number, null)              #(Optional) Setting this causes Terraform to wait for this number of instances from this Auto Scaling Group to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes.
    wait_for_elb_capacity     = optional(number, null)              #(Optional) Setting this will cause Terraform to wait for exactly this number of healthy instances from this Auto Scaling Group in all attached load balancers on both create and update operations. (Takes precedence over min_elb_capacity behavior
    target_group_arns         = optional(list(string), null)        #(Optional) Set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing
    default_cooldown          = optional(number, 300)               #(Optional) Amount of time, in seconds, after a scaling activity completes before another scaling activity can start.
    force_delete              = optional(bool, true)                #(Optional) Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling
    termination_policies      = optional(list(string), ["Default"]) #(Optional) List of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default. Additionally, the ARN of a Lambda function can be specified for custom termination policies.
    suspended_processes       = optional(list(string), null)        #(Optional) List of processes to suspend for the Auto Scaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer, InstanceRefresh. Note that if you suspend either the Launch or Terminate process types, it can prevent your Auto Scaling Group from functioning properly
    placement_group           = optional(string, null)              #(Optional) Name of the placement group into which you'll launch your instances, if any.
    enabled_metrics           = optional(list(string), null)        #(Optional) List of metrics to collect. The allowed values are defined by the underlying AWS API.
    metrics_granularity       = optional(string, "1Minute")         #(Optional) Granularity to associate with the metrics to collect. The only valid value is 1Minute. Default is 1Minute
    wait_for_capacity_timeout = string                              #(Default: "10m") Maximum duration that Terraform should wait for ASG instances to be healthy before timing out.
    protect_from_scale_in     = optional(bool, false)               #(Optional) Whether newly launched instances are automatically protected from termination by Amazon EC2 Auto Scaling when scaling in
    service_linked_role_arn   = optional(string, null)              #(Optional) ARN of the service-linked role that the ASG will use to call other AWS services
    desired_capacity          = optional(number, null)              #(Optional) Number of Amazon EC2 instances that should be running in the group
    max_instance_lifetime     = optional(number, null)              #(Optional) Maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 86400 and 31536000 seconds
    capacity_rebalance        = optional(bool, false)               #(Optional) Whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled.

    instance_refresh = optional(list(object({ #(Optional) If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated
      strategy = string                       # (Required) Strategy to use for instance refresh. The only allowed value is Rolling

      preferences = list(object({                       #(Optional) Override default parameters for Instance Refresh
        instance_warmup        = optional(number, null) #(Optional) Number of seconds until a newly launched instance is configured and ready to use. Default behavior is to use the Auto Scaling Group's health check grace period.
        min_healthy_percentage = optional(number, 90)   #(Optional) Amount of capacity in the Auto Scaling group that must remain healthy during an instance refresh to allow the operation to continue, as a percentage of the desired capacity of the Auto Scaling group. Defaults to 90
      }))
      triggers = optional(list(string), null) #(Optional) Set of additional property names that will trigger an Instance Refresh. A refresh will always be triggered by a change in any of launch_configuration, launch_template, or mixed_instances_policy.
    })), null)

    # launch_template = optional(list(object({
    #   launch_template_id = string
    #   version            = optional(string, "$Default")
    # })))

    mixed_instances_policy = optional(list(object({
      instances_distribution = list(object({
        on_demand_base_capacity                  = optional(number, 0)
        on_demand_percentage_above_base_capacity = optional(number, null)
        spot_allocation_strategy                 = optional(string, null)
      }))
        launch_template_id = string
      override = list(object({
        instance_type     = optional(string, null)
        weighted_capacity = optional(string, null)
      }))
    })))

    warm_pool = optional(list(object({
      pool_state                  = optional(string, "Stopped") #(Optional) Sets the instance state to transition to after the lifecycle hooks finish. Valid values are: Stopped (default), Running or Hibernated.
      min_size                    = optional(number, 0)         #(Optional) Minimum number of instances to maintain in the warm pool. This helps you to ensure that there is always a certain number of warmed instances available to handle traffic spikes. Defaults to 0 if not specified.
      max_group_prepared_capacity = optional(number, null)      #(Optional) Total maximum number of instances that are allowed to be in the warm pool or in any state except Terminated for the Auto Scaling group.

      instance_reuse_policy = optional(list(object({ # (Optional) Whether instances in the Auto Scaling group can be returned to the warm pool on scale in. The default is to terminate instances in the Auto Scaling group when the group scales in.
        reuse_on_scale_in = optional(bool, null)     #(Optional) Whether instances in the Auto Scaling group can be returned to the warm pool on scale in.
      })), null)
    })), null)

     tag = list(object({
      key = string
      values = string
     }))

    create_before_destroy = bool
  }))
}

