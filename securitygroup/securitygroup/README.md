<!-- BEGIN_TF_DOCS -->
## AWS Security Group Terraform module

This terraform module can be used to create one or more Security group & security group rules resources on AWS.

## Usage

```hcl
module "securitygroup" {
  source    = "./securitygroup"
  security_groups  =   var.security_groups
  common_tags = {
    Name        = "security_group_name"  # Update Seucrity group name here
    ProjectName = "TRHC_AWS_Migration" # Update Project name
    Provisioner = "Terraform"
  }
}
```
## Changelog

-   Version `v0.1.0`
    * Published artifact name: `securitygroup` 
    * Published artifact version: `0.1.0`
    * New module added.

## Included Files ##
```hcl
securitygroup
 ┣ securitygroup
 ┃ ┣ main.tf
 ┃ ┣ outputs.tf
 ┃ ┣ README.md
 ┃ ┗ variables.tf
 ┣ main.tf
 ┣ provider.tf
 ┣ terraform.tfvars
 ┗ variable.tf
 ```
## Features

This module will:

- Create one or multiple security group resources on AWS.

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


| Name                                                    | Version |
| ------------------------------------------------------- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0  |

## Providers

| Name                                              | Version |
| ------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a     |
## Module(s) Dependency 

* No Module Dependency

## Security Controls

| CATEGORY        | SECURITY STANDARD                                                                                                                                         | SECURITY DEFINITION                                                                                                                                                                                                                                               | REQUIRED? |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| Security        | Require secure transfer for REST API operations                                                                                                           | ensure that incoming requests to this storage account are made<br>only via HTTPS (default).                                                                                                                                                                       | recommended  |
| Security        | Enable blob public access                                                                                                                                 | When enabled, this setting allows a user with the appropriate permissions to enable anonymous public access to a container in the storage account (default). Disabling this setting prevents all anonymous public access to the storage account                   | recommended  |
| Network         | Networking access                                                                                                                                         | Configure network connectivity and routing preference settings for your new storage account                                                                                                                                                                       | recommended  |
| Network         | min_tls_version                                                                                                                                           | Supported tls version for the storage account & recommended is TLS1_2                                                                                                                                                                       | recommended  |
| Network         | Private Access                                                                                                                                            | Configure private endpoint to access the required storge types - blob, file, table, queue                                                                                                                                                                         | recommended  |
| Data Protection | Recovery                                                                                                                                                  | Protect your data from accidental or erroneous deletion or modification.                                                                                                                                                                                          | Optional  |
| Data Protection | Access control-Enable version-level immutability support                                                                                                  | Allows you to set time-based retention policy on the account-level that will apply to all blob versions                                                                                                                                                           | Optional  |
| Encryption      | Encryption Type                                                                                                                                           | Encryption of all storage types using Customer Managed Key                                                                                                                                                                                                        | Optional  |
| Tags            | Tags                                                                                                                                                      | Ensure mandatory tags are provided as per client requirements                                                                                                                                                                                                     | recommended  |
| Security        | [enable\_https\_traffic\_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#enable_https_traffic_only) | ensure that incoming requests to this route table are made only via HTTPS (default).                                                                                                                                                                          | Required  |

## Modules

| Name                                                                        | Source          | Version |
| --------------------------------------------------------------------------- | --------------- | ------- |
| <a name="module_securitygroup"></a> [securitygroup](#module\_securitygroup) | ./securitygroup | n/a     |


## Resources

| Name                                                                                                                                 | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_security_group.ec2_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource    |
| [aws_security_group.ib_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group)            | data source |
| [aws_security_group.ob_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group)            | data source |

## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags)                                                 | n/a                                                | `map`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `{}`    |    no    |
| <a name="input_ib_security_group_ids_map"></a> [ib\_security\_group\_ids\_map](#input\_ib\_security\_group\_ids\_map) | Specifies the Map of Security Group Id's           | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `{}`    |    no    |
| <a name="input_ob_security_group_ids_map"></a> [ob\_security\_group\_ids\_map](#input\_ob\_security\_group\_ids\_map) | Specifies the Map of Security Group Id's           | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `{}`    |    no    |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups)                                     | The network security groups with their properties. | <pre>map(object({<br>    sg_name     = string,<br>description = string,<br>vpc_id      = string,<br>inbound_rules=<br>optional(list(object({<br>to_port          = string,<br>from_port        = string,<br>protocol         = string,<br>description      = optional(string, null),<br>cidr_range       = optional(list(string), null),<br>ipv6_cidr_blocks = optional(list(string), null),<br>prefix_list_ids  = optional(list(string), null),<br>self             = optional(bool, false),<br>security_group_names = optional(list(string), null) })), []),<br>outbound_rules = optional(list(object({<br>to_port          = string,<br>from_port        = string<br>protocol      =string<br>description      = optional(string, null),<br>cidr_range       = optional(list(string), null),<br>ipv6_cidr_blocks = optional(list(string), null),<br>prefix_list_ids  = optional(list(string), null),<br>self             = optional(bool, false),<br>security_group_names = optional(list(string), null) })),<br>  }))</pre> | `{}`    |    no    |

## Outputs

| Name                                                              | Description                                |
| ----------------------------------------------------------------- | ------------------------------------------ |
| <a name="output_sg_output"></a> [sg\_output](#output\_sg\_output) | ###########output of Security Groups###### |
<!-- END_TF_DOCS -->