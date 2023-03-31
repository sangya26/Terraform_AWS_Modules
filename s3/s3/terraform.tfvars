# ################ create s3 buckets #####################
s3_bucket = {
  "mybucket111" = {
    bucket_name         = "tf-the-lav-222023" #(Optional, Forces new resource) The name of the bucket. Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length.
    force_destroy       = false               #(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed
    object_lock_enabled = true                #(Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false
    # acl                 = "private"      #The canned ACL to apply.

    #####versioning configuration #####
    versioning_configuration = [{ # (Required) Configuration block for the versioning parameters 
      status     = "Enabled"      #(Required) The versioning state of the bucket. Valid values: Enabled, Suspended, or Disabled. Disabled should only be used when creating or importing resources that correspond to unversioned S3 buckets.
      mfa_delete = "Disabled"     #(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: Enabled or Disabled.
    }]

    #### Accelrate Configuration ####
    status = "Enabled" #(Required) Transfer acceleration state of the bucket. Valid values: Enabled, Suspended.

    ##### payment_configuration ####
    payer = "Requester" # (Required) Specifies who pays for the download and request fees. Valid values: BucketOwner, Requester


    #### s3_bucket_logging ######
    target_bucket = "tf-the-lav-222023" #(Required) The name of the bucket where you want Amazon S3 to store server access logs
    target_prefix = "log/"              #(Required) A prefix for all log object keys.

    ####  object_lock_configuration ####
    # object_lock_enabled = "Enabled" #(Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Defaults to Enabled
    rules = [{            #(Required) A configuration block for specifying the default Object Lock retention settings for new objects placed in the specified bucket 
      mode = "COMPLIANCE" # (Required) The default Object Lock retention mode you want to apply to new objects placed in the specified bucket. Valid values: COMPLIANCE, GOVERNANCE.
      days = 5            # (Optional, Required if years is not specified) The number of days that you want to specify for the default retention period.
      // years = 2 #(Optional, Required if days is not specified) The number of years that you want to specify for the default retention period.
    }]

    #### AWS KMS KEY with server_side_encryption_configuration #####

    deletion_window_in_days = 10    #Optional) The waiting period, specified in number of days. 
    enable_key_rotation     = false #(Optional) Specifies whether key rotation is enabled. Defaults to false.\
    multi_region            = false #(Optional) Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false

    // server_side_encryption_configuration_rule  # (Required) Set of server-side encryption configuration rules.

    kms_master_key_id  = "aws/s3"  #(Optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms.
    sse_algorithm      = "aws:kms" #(Required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms
    bucket_key_enabled = "true"    #(Optional) Whether or not to use Amazon S3 Bucket Keys for SSE-KMS.


    #### ACL With Grant ####
    access_control_policy = [{
      grant = [{ # (Required) Set of grant configuration blocks       
        # grantee = [{             #(Required) Configuration block for the person being granted permissions
        type       = "Group"                                          # (Required) Type of grantee. Valid values: CanonicalUser, AmazonCustomerByEmail, Group.
        permission = "READ_ACP"                                       # (Required) Logging permissions assigned to the grantee for the bucket.
        uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery" # (Optional) URI of the grantee group.
        // email_address = "iactest@gmail.com" #(Optional) Email address of the grantee. 
        id = null #(Optional) Canonical user ID of the grantee.
        // DisplayName = "iacfilegrant"
        # }]
      }]
      //Owner = {
      // displayName = "owner123"
      // id          = "98767888"
      // }
    }]



    #### cors_configuration ######
    cors_rule = [{                                                #(Required) Set of origins and methods (cross-origin access that you want to allow).
      allowed_headers = ["*"]                                     # (Optional) Set of Headers that are specified in the Access-Control-Request-Headers header.
      allowed_methods = ["PUT", "POST"]                           #(Required) Set of HTTP methods that you allow the origin to execute. Valid values are GET, PUT, HEAD, POST, and DELETE
      allowed_origins = ["https://s3-website-test.hashicorp.com"] #(Required) Set of origins you want customers to be able to access the bucket from.
      expose_headers  = ["ETag"]                                  # (Optional) Set of headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
      max_age_seconds = 0                                         #(Optional) Time in seconds that your browser is to cache the preflight response for the specified resource.
      },

      {                                                             #(Required) Set of origins and methods (cross-origin access that you want to allow).
        allowed_headers = ["*"]                                     # (Optional) Set of Headers that are specified in the Access-Control-Request-Headers header.
        allowed_methods = ["PUT"]                                   #(Required) Set of HTTP methods that you allow the origin to execute. Valid values are GET, PUT, HEAD, POST, and DELETE
        allowed_origins = ["https://s3-website-test.hashicorp.com"] #(Required) Set of origins you want customers to be able to access the bucket from.
        expose_headers  = ["ETag"]                                  # (Optional) Set of headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
        max_age_seconds = 0                                         #(Optional) Time in seconds that your browser is to cache the preflight response for the specified resource.
    }]

    rule = [{       #(Required) List of configuration blocks describing the rules managing the replication.
      id = "config" #(Required) Unique identifier for the rule. The value cannot be longer than 255 characters.
      # prefix  = "config/"  deprecated
      status = "Enabled" #(Required) Whether the rule is currently being applied. Valid values: Enabled or Disabled

      expiration = [{ #(Optional) Configuration block that specifies the expiration for the lifecycle of the object in the form of date, days and, whether the object has a delete marker.
        days = 91     # (Optional) Lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
        // date = " "      (Optional) Date the object is to be moved or deleted. Should be in RFC3339 format.
        // expired_object_delete_marker = false  #(Optional, Conflicts with date and days) Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions.
      }]

      transition = [{ #(Optional) Configuration block that specifies the expiration for the lifecycle of the object in the form of date, days and, whether the object has a delete marker.
        days = 90     # (Optional, Conflicts with date) Number of days after creation when objects are transitioned to the specified storage class. The value must be a positive integer. If both days and date are not specified, defaults to 0. Valid values depend on storage_class
        // date = " "    # (Optional, Conflicts with days) Date objects are transitioned to the specified storage class. The date value must be in RFC3339 format and set to midnight UTC e.g. 2023-01-13T00:00:00Z.
        storage_class = "STANDARD_IA" #Class of storage used to store the object. Valid Values: GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
      }]

      #The filter configuration block must either be specified as the empty configuration block (filter {}) or with exactly one of prefix, tag, and, object_size_greater_than or object_size_less_than specified.
      filter = [{
        and = [{                                   #Optional) Configuration block used to apply a logical AND to two or more predicates.
          and_prefix                   = "config/" #(Optional) Prefix identifying one or more objects to which the rule applies. Defaults to an empty string ("") if not specified.
          and_object_size_greater_than = 131072    #(Optional) Minimum object size to which the rule applies. Value must be at least 0 if specified.
          and_object_size_less_than    = 131073    # Optional) Maximum object size to which the rule applies. Value must be at least 1 if specified.
          and_tags = {                             # (Optional) Key-value map of resource tags.
            autoclean = "true"
            rule      = "log"
          }
        }]
        # prefix                   = "logs/" # (Optional) Prefix identifying one or more objects to which the rule applies.
        # object_size_greater_than = 0      # (Optional) Minimum object size to which the rule applies. Value must be at least 0 if specified.
        # object_size_less_than    = 1      # (Optional) Maximum object size to which the rule applies. Value must be at least 1 if specified.
        # tag = {
        #   tag_key   = "true" #(Required) Name of the object key.
        #   tag_value = "log"  # (Required) Value of the tag.
        # }


      }]

      noncurrent_version_transition = [{ #(Optional) Specifies when noncurrent object versions transitions.
        noncurrent_days = 30             #(Optional) Number of days an object is noncurrent before Amazon S3 can perform the associated action.
        storage_class   = "STANDARD_IA"  # (Required) Class of storage used to store the object. 
        //  newer_noncurrent_versions = 1 #Optional) Number of noncurrent versions Amazon S3 will retain. Must be a non-zero positive integer.
      }]

      noncurrent_version_expiration = [{ # (Optional) Specifies when noncurrent object versions expire.
        days = 90                        #(Optional) Number of days an object is noncurrent before Amazon S3 can perform the associated action. 
        // newer_noncurrent_versions = 1       # (Optional) Number of noncurrent versions Amazon S3 will retain. Must be a non-zero positive integer.  
      }]
    }]

    abort_incomplete_multipart_upload = [{
      days_after_initiation = 1
    }]

    access_block = [{
      block_public_acls       = true  #(Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false.
      block_public_policy     = false # (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false
      ignore_public_acls      = true  #(Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false
      restrict_public_buckets = true  #(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false
    }]

    ########### aws_s3_bucket_metric #######

    name = "ImportantBlueDocuments" #(Required) Unique identifier of the metrics configuration for the bucket. Must be less than or equal to 64 characters in length.

    filter = [{                         # (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags
      prefix = "ImportantBlueDocuments" # (Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags
    }]
    // tags = [{  # (Optional) Object tags for filtering (up to 10).
    //   priority = "high"
    //   class    = "blue"
    // }]


    index_document = [{     #(Optional, Required if redirect_all_requests_to is not specified) The name of the index document
      suffix = "index.html" #(Required) Suffix that is appended to a request that is for a directory on the website endpoint.
    }]
    # error_document = [{  # (Optional, Conflicts with redirect_all_requests_to) The name of the error document
    #   key = "error.html" # (Required) Object key name to use when a 4XX class error occurs.
    # }]
    # index_document = "index.html"
    #     error_document = "error.html"
    routing_rule = [{ #(Optional, Conflicts with redirect_all_requests_to and routing_rules) List of rules that define when a redirect is applied and the redirect behavior 
      condition = [{    #(Optional) Configuration block for describing a condition that must be met for the specified redirect to apply. 
        //  http_error_code_returned_equals = ""
        key_prefix_equals = "docs/" # (Required) The object key name to use when a 4XX class error occurs.
      }]
      redirect = [{ #(Required) Configuration block for redirect information.
        // host_name               = ""   # (Optional) Host name to use in the redirect request.
        // http_redirect_code      = ""    #(Optional) HTTP redirect code to use on the response.
        // protocol                = "http"   # (Optional) Protocol to use when redirecting requests. The default is the protocol that is used in the original request. Valid values: http, https.
        replace_key_prefix_with = "documents/" # (Optional, Conflicts with replace_key_with) Object key prefix to use in the redirect request. 
        //  replace_key_with        = "error.html"
      }]
    }]







  }
}



