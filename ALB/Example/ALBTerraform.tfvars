APPLICATION_LB = {
  ALB1 = {
    name                       = "ALBTest1"    #(Optional) The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb.
    internal                   = true          #(Optional) If true, the LB will be internal.
    load_balancer_type         = "application" #(Optional) The type of load balancer to create. Possible values are application, gateway, or network. The default value is application.
    security_groups            = []            #(Optional) A list of security group IDs to assign to the LB.
    subnets                    = []            #(Optional) A list of subnet IDs to attach to the LB.
    drop_invalid_header_fields = false         #(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. 
    enable_deletion_protection = false         #(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false.
    customer_owned_ipv4_pool   = null          #(Optional) The ID of the customer owned ipv4 pool to use for this load balancer.
    desync_mitigation_mode     = "defensive"   #(Optional) Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest.
    enable_http2               = true          #(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true.
    enable_waf_fail_open       = false         #(Optional) Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF. Defaults to false.
    idle_timeout               = "60"          #(Optional) The time in seconds that the connection is allowed to be idle. Default: 60.
    ip_address_type            = "ipv4"        #(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack.
    preserve_host_header       = false         #(Optional) Indicates whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change. Defaults to false.
    subnet_mapping1 = {                        #(Optional)But while using subnet mapping, need to use 2 mappings with subnets from different Availability Zone.
      subnet_id            = "subnet_id1"      #(Required) ID of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone.
      allocation_id        = null              #(Optional) The allocation ID of the Elastic IP address for an internet-facing load balancer.
      ipv6_address         = null              #(Optional) The IPv6 address. You associate IPv6 CIDR blocks with your VPC and choose the subnets where you launch both internet-facing and internal Application Load Balancers or Network Load Balancers.
      private_ipv4_address = null              #(Optional) The private IPv4 address for an internal load balancer.
    }

    subnet_mapping2 = {                        #(Optional)But while using subnet mapping, need to use 2 mappings with subnets from different Availability Zone.
      subnet_id            = "subnet_id2"      #(Required) ID of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone.
      allocation_id        = null              #(Optional) The allocation ID of the Elastic IP address for an internet-facing load balancer.
      ipv6_address         = null              #(Optional) The IPv6 address. You associate IPv6 CIDR blocks with your VPC and choose the subnets where you launch both internet-facing and internal Application Load Balancers or Network Load Balancers.
      private_ipv4_address = null              #(Optional) The private IPv4 address for an internal load balancer.
    }

    access_logs = {                           #(Optional) An Access Logs block. 
      bucket  = "bucket_name1"                #(Required) The S3 bucket name to store the logs in.
      prefix  = "test-lb1"                    #(Optional) The S3 bucket prefix. Logs are stored in the root if not configured.
      enabled = false                         #(Optional) Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified.
    }
    tags = {                                  #(Optional) A map of tags to assign to the resource. 
      Name = "ALBName1"
    }
  },

    ALB2 = {
    name                       = "ALBTest2"    #(Optional) The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb.
    internal                   = true          #(Optional) If true, the LB will be internal.
    load_balancer_type         = "application" #(Optional) The type of load balancer to create. Possible values are application, gateway, or network. The default value is application.
    security_groups            = []            #(Optional) A list of security group IDs to assign to the LB.
    subnets                    = []            #(Optional) A list of subnet IDs to attach to the LB.
    drop_invalid_header_fields = false         #(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. 
    enable_deletion_protection = false         #(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false.
    customer_owned_ipv4_pool   = null          #(Optional) The ID of the customer owned ipv4 pool to use for this load balancer.
    desync_mitigation_mode     = "defensive"   #(Optional) Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest.
    enable_http2               = true          #(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true.
    enable_waf_fail_open       = false         #(Optional) Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF. Defaults to false.
    idle_timeout               = "60"          #(Optional) The time in seconds that the connection is allowed to be idle. Default: 60.
    ip_address_type            = "ipv4"        #(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack.
    preserve_host_header       = false         #(Optional) Indicates whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change. Defaults to false.
    subnet_mapping1 = {                        #(Optional)But while using subnet mapping, need to use 2 mappings with subnets from different Availability Zone.
      subnet_id            = "subnet_id3"      #(Required) ID of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone.
      allocation_id        = null              #(Optional) The allocation ID of the Elastic IP address for an internet-facing load balancer.
      ipv6_address         = null              #(Optional) The IPv6 address. You associate IPv6 CIDR blocks with your VPC and choose the subnets where you launch both internet-facing and internal Application Load Balancers or Network Load Balancers.
      private_ipv4_address = null              #(Optional) The private IPv4 address for an internal load balancer.
    }

    subnet_mapping2 = {                        # (Optional)But while using subnet mapping, need to use 2 mappings with subnets from different Availability Zone.
      subnet_id            = "subnet_id4"      #(Required) ID of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone.
      allocation_id        = null              #(Optional) The allocation ID of the Elastic IP address for an internet-facing load balancer.
      ipv6_address         = null              #(Optional) The IPv6 address. You associate IPv6 CIDR blocks with your VPC and choose the subnets where you launch both internet-facing and internal Application Load Balancers or Network Load Balancers.
      private_ipv4_address = null              #(Optional) The private IPv4 address for an internal load balancer.
    }

    access_logs = {                           #(Optional) An Access Logs block. 
      bucket  = "bucket_name2"                #(Required) The S3 bucket name to store the logs in.
      prefix  = "test-lb2"                    #(Optional) The S3 bucket prefix. Logs are stored in the root if not configured.
      enabled = false                         #(Optional) Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified.
    }
    tags = {                                  #(Optional) A map of tags to assign to the resource. 
      Name = "ALBName2"
    }
  }
}