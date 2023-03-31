Version v0.1.0
<!-- BEGIN_TF_DOCS -->
# Create One or more S3 with AWS 
This Module allows you to create and manage S3 bucket with AWS.

## Changelog

-   Version `v0.1.0`
    * Published artifact name: `S3` 
    * Published artifact version: `0.1.0`
    * New module added.

To run this example you need to execute

$terraform init
$terraform plan 
$terraform apply
Note that this example may create resources which can cost money (AWS S3, for example). Run terraform destroy when you don't need these resources.

## Includes

- README.md
- main.tf
- provider.tf
- terraform.tfvars
- variables.tf

## Features

This module will:

- Create S3 bucket in AWS.

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
    3. (For testing module) Open terminal inside s3 folder and run terraform commands provided below.
    4. (For using this module) Copy code from the s3/main.tf, give path to the module in "source".
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

* Module "resourcegroup" ("./S3")


## Security Controls

| Name        | Varible                                                                                                                                          |  DEFINITION                                                                                                                                                                                                                                               | REQUIRED? |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| bucket         | bucket name                                                                                                                                         | The names of the bucket to be created                                                                                                                                                                      | required  |
| Launch Template         | Launch template access                                                                                                                                         | Launch template with appropriate mapping to versioning of your S3                                                                                                                                                                       | required  |

These features of S3 bucket configurations are supported:

<br>public access Block
<br>access logging
<br>versioning
<br>CORS
<br>lifecycle rules
<br>server-side encryption
<br>object locking
<br>Cross-Configuration
<br>ownership controls

## Resources

| Name | Type |
|------|------|
| [aws_S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/S3) | resource |
| 






## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_S3"></a> [S3](#input\_S3)                                     | The S3 with their properties. | <pre>map(object({ <br> bucket_name         = string <br>force_destroy       = optional(bool, false)<br>object_lock_enabled = optional(bool, false)<br># acl = optional(string, null)<br>versioning_configuration = list(object({<br>status     = optional(string, "Disabled")<br>mfa_delete = optional(string, "Disabled")}))<br>status = optional(string, null)<br>payer = optional(string, null) <br>target_bucket = string<br> target_prefix = optional(string, null)<br><br>rules = list(object({<br>mode = string<br>days = optional(number, null)<br>// years = optional(number, null)    })) <br>deletion_window_in_days = optional(number, null)<br>enable_key_rotation     = optional(bool, false)<br>multi_region            = optional(bool, false)<br>kms_master_key_id  = optional(string, null)<br>sse_algorithm      = string<br>bucket_key_enabled = optional(string, null)<br>access_control_policy = optional(list(object({<br>grant = list(object({<br>type          = string<br>permission    = string<br>uri           = optional(string, null)<br>email_address = optional(string, null)<br>// DisplayName = optional(string,null)<br>id = optional(string, null)<br>//owner = list(object({<br>// displayName = optional(string, null)<br>// id          = optional(string, null)<br>//}))}))<br>})), null)<br>cors_rule = list(object({<br>allowed_headers = optional(list(string), null)<br>allowed_methods = list(string)<br>allowed_origins = list(string)<br>expose_headers  = optional(list(string), nulll)<br>max_age_seconds = optional(number, null)}))<br>##### life cycle configuration #######<br>rule = optional(list(object({<br>id     = string<br>status = string<br>expiration = optional(list(object({<br>days                         = optional(number, null)<br>date                         = optional(string, null)<br>expired_object_delete_marker = optional(bool, false) })), null)<br>transition = optional(list(object({<br>//date          = optional(string,null)<br>days          = optional(number, null)<br>storage_class = string<br>})), null)<br>filter = optional(list(object({<br>and = optional(list(object({<br>and_prefix                   = optional(string, null)<br>and_object_size_greater_than = optional(number, null)<br>and_object_size_less_than    = optional(number, null)<br>and_tags                     = optional(map(string))})))<br>prefix                   = optional(string, null)<br>object_size_greater_than = optional(number, null)<br>object_size_less_than    = optional(number, null)<br>tag = optional(list(object({<br>tag_key   = string<br>tag_value = string<br>})))<br>})))<br>noncurrent_version_transition = optional(list(object({<br>noncurrent_days = optional(number, null)<br>storage_class   = string<br>// newer_noncurrent_versions = optional(number,null)<br>})), null)<br>noncurrent_version_expiration = optional(list(object({<br>days = optional(number, null)<br>// newer_noncurrent_versions = optional(number,null)<br>})), null)<br>abort_incomplete_multipart_upload = optional(list(object({<br>days_after_initiation = number<br>})), [])<br>})))<br>access_block = optional(list(object({<br>block_public_acls       = optional(bool, false)<br>block_public_policy     = optional(bool, false)<br>ignore_public_acls      = optional(bool, false)<br>restrict_public_buckets = optional(bool, false)})))<br>name = string<br>filter = list(object({<br>prefix = string<br>}))<br>// tags = list(object({<br>//   priority = string<br>//   class    = string<br>index_document           = list(object({<br>suffix = string }))<br>error_document           = optional(list(object({<br>key = string })))<br>redirect_all_requests_to = optional(string, "https://")<br>routing_rule = list(object({<br>condition = list(object({<br> key_prefix_equals = optional(string, null)}))<br>redirect  = list(object({<br>replace_key_prefix_with= optional(string, null)})) })) })) }  // </pre> | `{}`    |    yes    |


## Outputs

| Name | Description |
|------|-------------|
| <a name="S3_id"></a> [S3\_ids](#output\_subnet_\_ids) | S3 names and resource IDs |


<!-- END_TF_DOCS -->