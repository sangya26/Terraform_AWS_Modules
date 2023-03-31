<!-- BEGIN_TF_DOCS -->
## AWS Route table Terraform module

This terraform module can be used to create one or more Route table & route table rules resources on AWS.

## Usage

```hcl
module "routetable" {
  source          = "./routetable"
  routetable = var.routetable
}
```
## Changelog

-   Version `v0.1.0`
    * Published artifact name: `Route_Table` 
    * Published artifact version: `0.1.0`
    * New module added.

## Includes
```hcl
ROUTE_TABLE
 ┣ routetable
 ┃ ┣ main.tf
 ┃ ┣ outputs.tf
 ┃ ┗ variables.tf
 ┣ main.tf
 ┣ provider.tf
 ┣ README.md
 ┣ terraform.tfvars
 ┗ variable.tf
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

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |


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
| Security        | [enable\_https\_traffic\_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#enable_https_traffic_only) | ensure that incoming requests to this route table are made only via HTTPS (default).                                                                                                                                                                          | Required  |

## Modules
| Name                                                                        | Source          | Version |
| --------------------------------------------------------------------------- | --------------- | ------- |
| <a name="module_routetable"></a> [routetable](#module\_securitygroup) | ../ | n/a     |
## Resources

| Name | Type |
|------|------|
| [aws_route_table.routetable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_routetable"></a> [routetable](#input\_routetable) | The route table with their properties. | <pre>map(object({<br>    vpc_id = string,<br>    subnet_association=optional(list(string),null),<br>nat_gateway_association=optional(list(string),null),<br>    route_args = optional(list(object({<br>      cidr_block                 = string,<br>      ipv6_cidr_block            = optional(string, null),<br>      destination_prefix_list_id = optional(string, null),<br>      vpc_peering_connection_id  = optional(string, null),<br>      vpc_endpoint_id            = optional(string, null),<br>      transit_gateway_id         = optional(string, null),<br>      network_interface_id       = optional(string, null),<br>      nat_gateway_id             = optional(string, null),<br>      local_gateway_id           = optional(string, null),<br>      gateway_id                 = optional(string, null),<br>      egress_only_gateway_id     = optional(string, null),<br>      core_network_arn           = optional(string, null),<br>      carrier_gateway_id         = optional(string, null)<br>    }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_output"></a> [route\_table\_output](#output\_route\_table\_output) | ##Route\_table OUTPUT##### |
<!-- END_TF_DOCS -->