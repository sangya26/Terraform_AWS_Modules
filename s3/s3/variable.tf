################ create s3 buckets #####################
variable "s3_bucket" {
  type = map(object(
    {
      bucket_name         = string
      force_destroy       = optional(bool, false)
      object_lock_enabled = optional(bool, false)


      # acl = optional(string, null)



      versioning_configuration = list(object({
        status     = optional(string, "Disabled")
        mfa_delete = optional(string, "Disabled")
      }))




      status = optional(string, null)

      payer = optional(string, null)

      target_bucket = string
      target_prefix = optional(string, null)

      ### object lock configuration ####
      rules = list(object({
        mode = string
        days = optional(number, null)
        // years = optional(number, null)      
      }))


      ### aws_kms_key #######
      deletion_window_in_days = optional(number, null)
      enable_key_rotation     = optional(bool, false)
      multi_region            = optional(bool, false)

      kms_master_key_id  = optional(string, null)
      sse_algorithm      = string
      bucket_key_enabled = optional(string, null)



      access_control_policy = optional(list(object({
        grant = list(object({
          type          = string
          permission    = string
          uri           = optional(string, null)
          email_address = optional(string, null)
          // DisplayName = optional(string,null)
          id = optional(string, null)


          //owner = list(object({
          // displayName = optional(string, null)
          // id          = optional(string, null)
          //}))
        }))
      })), null)

      cors_rule = list(object({
        allowed_headers = optional(list(string), null)
        allowed_methods = list(string)
        allowed_origins = list(string)
        expose_headers  = optional(list(string), null)
        max_age_seconds = optional(number, null)
      }))

      ##### life cycle configuration #######

      rule = optional(list(object({
        id     = string
        status = string
        expiration = optional(list(object({
          days                         = optional(number, null)
          date                         = optional(string, null)
          expired_object_delete_marker = optional(bool, false)
        })), null)

        transition = optional(list(object({
          //date          = optional(string,null)
          days          = optional(number, null)
          storage_class = string
        })), null)

        filter = optional(list(object({
          and = optional(list(object({
            and_prefix                   = optional(string, null)
            and_object_size_greater_than = optional(number, null)
            and_object_size_less_than    = optional(number, null)
            and_tags                     = optional(map(string))
          })))
          prefix                   = optional(string, null)
          object_size_greater_than = optional(number, null)
          object_size_less_than    = optional(number, null)
          tag = optional(list(object({
            tag_key   = string
            tag_value = string
          })))
        })))

        noncurrent_version_transition = optional(list(object({
          noncurrent_days = optional(number, null)
          storage_class   = string
          // newer_noncurrent_versions = optional(number,null)
        })), null)

        noncurrent_version_expiration = optional(list(object({
          days = optional(number, null)
          // newer_noncurrent_versions = optional(number,null)
        })), null)

        abort_incomplete_multipart_upload = optional(list(object({
          days_after_initiation = number
        })), [])
      })))

      access_block = optional(list(object({
        block_public_acls       = optional(bool, false)
        block_public_policy     = optional(bool, false)
        ignore_public_acls      = optional(bool, false)
        restrict_public_buckets = optional(bool, false)
      })))



      ########### aws_s3_bucket_metric #######

      name = string

      filter = list(object({
        prefix = string
      }))
      // tags = list(object({
      //   priority = string
      //   class    = string
      // }))

            index_document           = list(object({
                     suffix = string
            })) 
          error_document           = optional(list(object({
            key = string
          })))
          redirect_all_requests_to = optional(string, "https://")

          routing_rule = list(object({
            condition = list(object({
            key_prefix_equals = optional(string, null)
            }))
            redirect  = list(object({
             replace_key_prefix_with= optional(string, null)
             }))

  }))
    }))
}



