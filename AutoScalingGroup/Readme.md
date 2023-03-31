Version v0.1.0
<!-- BEGIN_TF_DOCS -->
# Create One or more Auto Scaling Group with AWS 
This Module allows you to create and manage one or multiple Auto Scaling Group with AWS.

## Changelog

-   Version `v0.1.0`
    * Published artifact name: `auto scaling group` 
    * Published artifact version: `0.1.0`
    * New module added.

## Includes

- autoScale/main.tf
- autoScale/variables.tf
- autoScale/output.tf
- README.md
- main.tf
- provider.tf
- terraform.tfvars
- variables.tf

## Features

This module will:

- Create one or multiple Auto Scaling Groups in AWS.

## How to use?
* Azure DevOps:
    1. Copy `var-{module.name}.auto.tfvars` file in environment folder of your repository/branch. 
    2. Rename it to `var-${tfvars_file_name}.auto.tfvars` if required.
    3. Modify values of the attributes if required. And commit changes if any.
    4. Go-to `Pipline.{env}.yaml` file and add resource block if it is not there. And commit changes.
    5. Execute the pipeline by selecting `{tfvars_file_name}_plan` or `{tfvars_file_name}_apply` or both.
    
    ---

* GitLab:
    1. Copy contains of `main.tf` file
    2. Open gitlab. Move to required `{organization}/{project}/{subproject}/{dir_if_any}`.
    3. Create a new file say `main.tf`. Paste what you copied from `main.tf`
    4. Check source and modify value of attributes if required. Commit changes.
    5. Create a new file `provider.tf` in same directory and paste the contains of `provider.tf` there.
    6. Make required changes in `.gitlab-ci.yml` file and execute the pipeline.
    
    ---

* Local:
    1. Clone the repo to local.
    2. Make sure to setup terraform and environment paths correctly
    3. (For testing module) Open terminal inside example folder and run terraform commands provided below. (change `source = "../"`)
    4. (For using this module) Copy code from the example/main.tf, give path to the module in "source".
    6. Modify value of attributes if required.
    5. In same directory where module is being called, open terminal and run terraform commands provided below.
    6. Terraform commands: `terraform init` -> `terraform plan` -> `terraform apply`

    ---


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | `1.3.7` |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_azurerm) | `2.9.18` |
| <a name="provider_local"></a> [local](#provider\_local) | `latest` |

## Module(s) Dependency 

* Module "resourcegroup" ("./autoScale")


## Security Controls

| CATEGORY        | SECURITY STANDARD                                                                                                                                         | SECURITY DEFINITION                                                                                                                                                                                                                                               | REQUIRED? |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| Network         | Networking access                                                                                                                                         | Configure network connectivity and routing preference settings for your new auto scaling groups                                                                                                                                                                       | required  |
| Launch Template         | Launch template access                                                                                                                                         | Launch template with appropriate mapping to Subnet and Security groups of your network for your auto scaling group                                                                                                                                                                       | required  |


## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| 






## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_auto_scaling_group"></a> [auto_scaling_group](#input\_auto_scaling_group)                                     | The auto_scaling_groups with their properties. | <pre>map(object({<br>name                      = string <br>vpc_zone_identifier       = list(string) <br>max_size                  = number                        <br>min_size                  = number <br>load_balancers            = optional(list(string), null) <br>health_check_grace_period = optional(number, 300)               <br>health_check_type         = optional(string, "EC2") <br>min_elb_capacity          = optional(number, null) <br>wait_for_elb_capacity     = optional(number, null) <br>target_group_arns         = optional(list(string), null) <br>default_cooldown          = optional(number, 300) <br>force_delete              = optional(bool, true) <br>termination_policies      = optional(list(string), ["Default"]) <br>suspended_processes       = optional(list(string), null)       <br>placement_group           = optional(string, null) <br>enabled_metrics           = optional(list(string), null) <br>metrics_granularity       = optional(string, "1Minute") <br>wait_for_capacity_timeout = string <br>protect_from_scale_in     = optional(bool, false) <br>service_linked_role_arn   = optional(string, null) <br>desired_capacity          = optional(number, null) <br>max_instance_lifetime     = optional(number, null) <br>capacity_rebalance        = optional(bool, false) <br>instance_refresh = optional(list(object({ <br>strategy = string <br>preferences = list(object({ <br>instance_warmup        = optional(number, null) <br>min_healthy_percentage = optional(number, 90) <br>})) <br>triggers = optional(list(string), null) <br>})), null) <br>launch_template = optional(list(object({ <br>launch_template_id = string <br>version            = optional(string, "$Default") <br>}))) <br>mixed_instances_policy = optional(list(object({ <br>instances_distribution = list(object({ <br>on_demand_base_capacity                  = optional(number, 0) <br>on_demand_percentage_above_base_capacity = optional(number, null) <br>spot_allocation_strategy                 = optional(string, null) <br>})) <br>launch_template_id = string <br>override = list(object({ <br>instance_type     = optional(string, null) <br>weighted_capacity = optional(string, null)<br>}))<br>}))) <br>warm_pool = optional(list(object({ <br>pool_state                  = optional(string, "Stopped") <br>min_size                    = optional(number, 0) <br>max_group_prepared_capacity = optional(number, null) <br>instance_reuse_policy = optional(list(object({ <br>reuse_on_scale_in = optional(bool, null) <br>})), null) <br>})), null) <br>tag = list(object({ <br>key = string <br>values = string <br>})) <br>create_before_destroy = bool}))</pre> | `{}`    |    yes    |


## Outputs

| Name | Description |
|------|-------------|
| <a name="auto_scaling_group_id"></a> [auto_scaling_group\_ids](#output\_subnet_\_ids) | Auto Scaling Group names and resource IDs |


<!-- END_TF_DOCS -->