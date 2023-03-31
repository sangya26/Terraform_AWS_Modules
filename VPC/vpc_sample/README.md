<!-- BEGIN_TF_DOCS -->
## AWS VPC Terraform module

This terraform module can be used to create one or more VPC & VPC rules resources on AWS.

## Usage

```hcl
module "vpc" {
  source    = "./vpc_sample"
 vpc  =   var.vpc
  }
}
```
To run this example you need to execute

```hcl
$terraform init
$terraform plan 
$terraform apply
```
Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run terraform destroy when you don't need these resources.

## Changelog

-   Version `v0.1.0`
    * Published artifact name: `VPC` 
    * Published artifact version: `0.1.0`
    * New module added.

## Included Files ##
```hcl
awsvpctf
 ┣ vpc_sample
 ┃ ┣ main.tf
 ┃ ┣ outputs.tf
 ┃ ┗ variables.tf
 ┣ example
 ┃ ┣ main.tf
 ┃ ┣provider.tf
 ┃ ┣ README.md
 ┃ ┣ terraform.tfvars
 ┃ ┗ variable.tf
 ```

## Features

This module will:

- Create one or multiple route table resources on AWS.

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
    3. Create a new file say `example/main.tf`. Paste what you copied from `main.tf`
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
| Security        | [enable\_https\_traffic\_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_https_traffic_only) | ensure that incoming requests to this route table are made only via HTTPS (default).                                                                                                                                                                          | Required  |


## Modules

| Name                                                                        | Source          | Version |
| --------------------------------------------------------------------------- | --------------- | ------- |
| <a name="module_vpc"></a> [vpc](#module\vpc) | ./Vpc | n/a     |

## Resources

| Name                                                                                                                                 | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource    |


## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags)                                                 | no/a                                                | `map(object)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `{}`    |    no    |
| <a name="input_vpc"></a> [vpc\_ids\_map](#input\vpc\_ids\_map) | Specifies the Map of vpc Id's           | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `{}`    |    no    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `{}`    |    no    |
| <a name="input_vpc"></a> [vpc](#input\vpc)                                     | The network vpc with their properties. | <pre> map(object({<br>cidr_block                           = string<br>instance_tenancy                     = optional(string, "default")<br>enable_dns_hostnames                 = optional(bool, true)<br>enable_dns_support                   = optional(bool, true)<br>enable_network_address_usage_metrics = optional(bool, false)<br>ipv4_ipam_pool_id                    = optional(string, null)<br># ipv4_netmask_length                  = optional(string,null)<br>tags = map(string)}))</pre> | `{}`    |    no    |

## Outputs

| Name                                                              | Description                                |
| ----------------------------------------------------------------- | ------------------------------------------ |
| <a name="output_vpc_output"></a> [vpc\_output](#output\_vpc\_output) | ###########output of VPC ###### |
<!-- END_TF_DOCS -->