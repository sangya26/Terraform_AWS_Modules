Version v0.1.0
<!-- BEGIN_TF_DOCS -->
# Create One or more Subnets with AWS 
This Module allows you to create and manage one or multiple Subnets with AWS.

## Changelog

-   Version `v0.1.0`
    * Published artifact name: `subnet` 
    * Published artifact version: `0.1.0`
    * New module added.

## Includes

- Subnets/main.tf
- Subnets/variables.tf
- Subnets/output.tf
- Subnets/README.md
- example/main.tf
- example/provider.tf
- example/terraform.tfvars
- example/variables.tf

## Features

This module will:

- Create one or multiple Subnets in AWS.

## How to use?
* Azure DevOps:
    1. Copy `var-{module.name}.auto.tfvars` file in environment folder of your repository/branch. 
    2. Rename it to `var-${tfvars_file_name}.auto.tfvars` if required.
    3. Modify values of the attributes if required. And commit changes if any.
    4. Go-to `Pipline.{env}.yaml` file and add resource block if it is not there. And commit changes.
    5. Execute the pipeline by selecting `{tfvars_file_name}_plan` or `{tfvars_file_name}_apply` or both.
    
    ---

* GitLab:
    1. Copy contains of `example/main.tf` file
    2. Open gitlab. Move to required `{organization}/{project}/{subproject}/{dir_if_any}`.
    3. Create a new file say `main.tf`. Paste what you copied from `example/main.tf`
    4. Check source and modify value of attributes if required. Commit changes.
    5. Create a new file `provider.tf` in same directory and paste the contains of `example/provider.tf` there.
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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | `2.9.18` |
| <a name="provider_local"></a> [local](#provider\_local) | `latest` |

## Module(s) Dependency 

* Module "resourcegroup" ("./Subnets")


## Security Controls

| CATEGORY        | SECURITY STANDARD                                                                                                                                         | SECURITY DEFINITION                                                                                                                                                                                                                                               | REQUIRED? |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| Network         | Networking access                                                                                                                                         | Configure network connectivity and routing preference settings for your new subnets                                                                                                                                                                       | required  |


## Resources

| Name | Type |
|------|------|
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [data.aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/3.5.0/docs/data-sources/vpc) | resource |




## Inputs

## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_region"></a> [region](#input\_region)                                                 | Specify the region where the subnet will be provisioned                                               | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `{}`    |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input\_vpc_id) | Specify the VPC Id in which the subnets will be provisioned       | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `{}`    |    yes    |
| <a name="input_subnet"></a> [subnets](#input\_subnet)                                     | The network subnet with their properties. | <pre>map(object({<br>tags                                           = map(string)<br>availability_zone                              = optional(string, null)<br>cidr_block                                     = string<br>enable_dns64                                   = optional(bool, false)<br>enable_resource_name_dns_aaaa_record_on_launch = optional(bool, false)<br>enable_resource_name_dns_a_record_on_launch    = optional(bool, false)<br>assign_ipv6_address_on_creation                = optional(bool, false)<br>#CIDR_range_subnet_ipv6                          = string<br>ipv6_native                     = optional(bool, false)<br>customer_owned_ipv4_pool        = optional(string, null)<br>map_customer_owned_ip_on_launch = optional(bool, false)<br>outpost_arn                     = optional(string, null)<br>map_public_ip_on_launch         = optional(bool, false)}))</pre> | `{}`    |    yes    |


## Outputs

| Name | Description |
|------|-------------|
| <a name="subnet_ids"></a> [subnet\_ids](#output\_subnet_\_ids) | Subnet names and resource IDs |


<!-- END_TF_DOCS -->