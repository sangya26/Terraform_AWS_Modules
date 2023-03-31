<!-- BEGIN_TF_DOCS -->
## AWS Applicaion Load Balancer Terraform module

This terraform module can be used to create one or more Security group & security group rules resources on AWS.

## Requirements


| Name                                                    | Version |
| ------------------------------------------------------- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0  |

## Providers

| Name                                              | Version |
| ------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a     |


## Included Files ##
```hcl
awsalbtf
 ┣ main.tf
 ┣ provider.tf
 ┣ README.md
 ┗ variable.tf
 ┣ Example
 ┃ ┣ ALBTerraform.tfvars
 ```


## Resources

| Name                                                                                                                                 | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_lb.applicaion_load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource    |


## Inputs

| Name                                                                                                                  | Description                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default | Required |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="ApplicaionLoadBalancer"></a> [APPLICATION_LB](#input\_applicaion\_loadbalancer)                                     | The applicaion load balancer with their properties. | <pre> map(object({ <br>name               = string, <br>internal           = optional(bool,false), <br>load_balancer_type = optional(string,"application"), <br>security_groups    = optional(list(string),null), <br>subnets                          = list(string), <br>drop_invalid_header_fields       = optional(bool,false), <br>enable_cross_zone_load_balancing = optional(bool,false), <br>enable_deletion_protection       = optional(bool,false), <br>customer_owned_ipv4_pool         = optional(string,null), <br>desync_mitigation_mode           = optional(string,"defensive"), <br>enable_http2                     = optional(bool,true), <br>enable_waf_fail_open             = optional(bool,false), <br>idle_timeout                     = optional(number, "60"), <br>ip_address_type                  = optional(string,null), <br>preserve_host_header             = optional(bool,false), <br>subnet_mapping1 = object({<br>subnet_id            = string, <br>allocation_id        = optional(string,null), <br>ipv6_address         = optional(string,null), <br>private_ipv4_address = optional(string,null)}),<br>subnet_mapping2 = object({<br>subnet_id            = string, <br>allocation_id        = optional(string,null), <br>ipv6_address         = optional(string,null), <br>private_ipv4_address = optional(string,null)}), <br>access_logs = object({<br>bucket  = string, <br>prefix  = optional(string,null, <br>enabled = optional(bool,false)}), <br>tags = map(string) }))</pre> | `{}`    |    no    |

<!-- END_TF_DOCS -->