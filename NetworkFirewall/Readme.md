Version v0.1.0
<!-- BEGIN_TF_DOCS -->
# Create One or more Network Firewall, Firewall policy, Firewall rule groups, Firewall logging Configuration with AWS 
This Module allows you to create and manage one or multiple Network Firewall, Firewall policy, Firewall rule groups, Firewall logging configuration with AWS.

## Changelog

-   Version `v0.1.0`
    * Published artifact name: `firewall` 
    * Published artifact version: `0.1.0`
    * New module added.

## Includes

- firewall/main.tf
- firewall/variables.tf
- firewall/output.tf
- README.md
- main.tf
- provider.tf
- terraform.tfvars
- variables.tf

## Features

This module will:

- Create one or multiple Network Firewall, Firewall policy, Firewall rule groups, Firewall logging configuration in AWS.

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
    3. (For testing module) Open terminal inside example folder and run terraform commands provided below. (change `source = "./"`)
    4. (For using this module) Copy code from the firewall/main.tf, give path to the module in "source".
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | `2.9.18` |
| <a name="provider_local"></a> [local](#provider\_local) | `latest` |

## Module(s) Dependency 

* Module "resourcegroup" ("./firewall")


## Security Controls

| CATEGORY        | SECURITY STANDARD                                                                                                                                         | SECURITY DEFINITION                                                                                                                                                                                                                                               | REQUIRED? |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| Network         | Networking access                                                                                                                                         | Configure network connectivity and subnet routing preference settings for your  Network firewall                                                                                                                                                                      | required  |
| Storage         | S3, CloudWatch, Kinesis Data Firehose                                                                                                                                         | Configure any of the storage resources with preference settings for firewall logging configuration                                                                                                                                                                       | required  |


## Resources

| Name | Type |
|------|------|
| [aws_networkfirewall_rule_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |
| [aws_networkfirewall_firewall_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall) | resource |
| [aws_networkfirewall_logging_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_logging_configuration) | resource |
| 






## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_firewall_policy"></a> [firewall-policy](#input\_firewall_policy)                                     | The network firewall policy with its properties. | <pre>map(object({ <br>name  = string <br>stateful_default_actions  = optional(list(string), null) <br>stateless_default_actions  = list(string) <br>stateless_fragment_default_actions = list(string) <br>stateless_rule_group_reference = optional(list(object({ <br>priority     = optional(number) <br>firewall_rule_group_key = string <br>})), null) <br>stateful_rule_group_reference = optional(list(object({ <br>priority     = optional(number) <br>firewall_rule_group_key = string <br>})), null) <br>stateful_engine_options = optional(list(object({ <br>rule_order = string <br>})), null) <br>stateless_custom_action = optional(list(object({ <br>action_name = string <br>dimension = list(object({ <br>value       = string <br>})) <br>})), null) <br>}))</pre> | `{}`    |    yes    |
| <a name="input_firewall"></a> [firewall](#input\_firewall)                                     | The network firewall with its properties. | <pre>map(object({ <br>name   = string <br>vpc_id   = string <br>firewall_policy_key = string <br>delete_protection                 = optional(bool, false) <br>firewall_policy_change_protection = optional(bool, false) <br>subnet_change_protection          = optional(bool, false) <br>subnet_mapping = list(object({ <br>subnet_id = string <br>})) <br>tags = map(string)<br>}))</pre> | `{}`    |    yes    |
| <a name="input_firewall_logging"></a> [firewall_logging_configuration](#input\_firewall_logginf_configuration)                                     | The network firewall with its properties. | <pre>map(object({ <br>firewall_key = string <br>logging_configuration = list(object({ <br>bucketName           = string <br>prefix               = string <br>log_destination_type = string <br>log_type             = string <br>})) <br>}))</pre> | `{}`    |    yes    |
| <a name="input_firewall_rule_group"></a> [firewall_rule_group](#input\_firewall_rule_group)                                     | The network firewall logging configuration with its properties. | <pre>map(object({ <br>capacity = string <br>name     = string <br>type     = string <br>rule_group = list(object({ <br>rules_source = list(object({ <br>generated_rules_type = string <br>target_types         = list(string) <br>targets              = list(string) <br>})) <br>rule_option = optional(list(object({ <br>keyword = string <br>settings = list(string)     <br>})), null) <br>ip_sets = optional(list(object({ <br>key = string <br>definition = list(string) <br>})), null)<br>reference_sets = optional(list(object({ <br>key = string <br>reference_arn = string <br>})),null) <br>})) <br>tags = map(string) <br>}))</pre> | `{}`    |    yes    |


## Outputs

| Name | Description |
|------|-------------|
| <a name="network_firewall_id"></a> [network_firewall\_ids](#output\_newtork_firewall_\_ids) | Network Firewall names and resource IDs |


<!-- END_TF_DOCS -->