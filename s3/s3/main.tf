################ create s3 buckets #####################
resource "aws_s3_bucket" "my_bucket" {
  for_each            = var.s3_bucket
  bucket              = each.value.bucket_name
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
  # acl                 = each.value.acl
}

##################### Create S3 Bucket ACL #######################
# resource "aws_s3_bucket_acl" "mybucket" {
#   for_each = var.s3_bucket
#   bucket   = each.value.bucket_name
#   acl = each.value.acl
# }


##################### Create S3 Bucket versioning configuration ##############
resource "aws_s3_bucket_versioning" "versioning_mybucket" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name
  # bucket = aws_s3_bucket.my_bucket.id
  dynamic "versioning_configuration" {
    for_each = each.value.versioning_configuration
    content {
      status     = versioning_configuration.value.status
      mfa_delete = versioning_configuration.value.mfa_delete

    }


  }
}


##################### Create S3 Buckt Accelrate Configuration ###################
resource "aws_s3_bucket_accelerate_configuration" "accelerate_configuration_mybucket" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name
  status   = each.value.status
}


############################ payment_configuration ####################
resource "aws_s3_bucket_request_payment_configuration" "payment_configuration" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name
  payer    = each.value.payer
}

######################## s3_bucket_logging #########################
resource "aws_s3_bucket_logging" "log_bucket" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name

  target_bucket = each.value.target_bucket
  target_prefix = each.value.target_prefix

  depends_on = [
    aws_s3_bucket.my_bucket
  ]
}

#####################  object_lock_configuration ############

resource "aws_s3_bucket_object_lock_configuration" "object_lock_configuration_mybucket" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name


  dynamic "rule" {
    for_each = each.value.rules

    content {
      default_retention {
        mode = rule.value.mode
        days = rule.value.days

        // years = each.value.object_lock_configuration_rule.default_retention.years
      }
    }
  }
}



######################## AWS KMS KEY with server_side_encryption_configuration ###################
resource "aws_kms_key" "mykey" {
  for_each = var.s3_bucket
  # bucket   = each.value.bucket_name
  deletion_window_in_days = each.value.deletion_window_in_days
  enable_key_rotation     = each.value.enable_key_rotation
  multi_region            = each.value.multi_region
  //  description             = "This key is used to encrypt bucket objects"

}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey[each.key].arn
      sse_algorithm     = each.value.sse_algorithm
    }
    bucket_key_enabled = each.value.bucket_key_enabled
  }
}



############################## With Grant ######################

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket_acl" "acl_bucket" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name


  dynamic "access_control_policy" {
    for_each = each.value.access_control_policy

    content {
      dynamic "grant" {
        for_each = access_control_policy.value.grant

        content {
          grantee {
            type          = grant.value.type
            id            = grant.value.id
            email_address = grant.value.email_address
            uri           = grant.value.uri
          }

          permission = grant.value.permission
        }
      }
      owner {
        //  displayName = access_control_policy.owner.value.displayName
        id = data.aws_canonical_user_id.current.id

      }
    }

  }
}
############################## cors_configuration ######################
resource "aws_s3_bucket_cors_configuration" "cors_configuration" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name

  dynamic "cors_rule" {
    for_each = each.value.cors_rule

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}

########### aws_s3_bucket_lifecycle_configuration ######
resource "aws_s3_bucket_lifecycle_configuration" "bucket_configuration" {
  for_each = var.s3_bucket
  bucket   = aws_s3_bucket.my_bucket[each.key].id

  dynamic "rule" {
    for_each = each.value.rule

    content {
      # prefix  = rule.value.prefix
      # enabled = rule.value.enabled
      id     = rule.value.id
      status = rule.value.status

      dynamic "expiration" {
        for_each = rule.value.expiration != null ? rule.value.expiration : []
        content {
          days = expiration.value.days
          date = expiration.value.date
          // expired_object_delete_marker  = expiration.value.expired_object_delete_marker
        }
      }

      dynamic "transition" {
        for_each = rule.value.transition != null ? rule.value.transition : []

        content {
          //date          = transition.value.date
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }


      dynamic "filter" {
        for_each = rule.value.filter != null ? rule.value.filter : []
        content {
          dynamic "and" {
            for_each = filter.value.and != null ? filter.value.and : []
            content {
              prefix                   = and.value.and_prefix
              tags                     = and.value.and_tags
              object_size_greater_than = and.value.and_object_size_greater_than
              object_size_less_than    = and.value.and_object_size_less_than
            }
          }
          object_size_greater_than = filter.value.object_size_greater_than
           object_size_less_than    = filter.value.object_size_less_than
           prefix                   = filter.value.prefix
          dynamic "tag" {
            for_each = filter.value.tag != null ? filter.value.tag : []
            content {
              key   = filter.value.tag_key
              value = filter.value.tag_value
            }

          }

        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = rule.value.noncurrent_version_transition != null ? rule.value.noncurrent_version_transition : []
        content {
          noncurrent_days = noncurrent_version_transition.value.noncurrent_days
          storage_class   = noncurrent_version_transition.value.storage_class
        }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = rule.value.abort_incomplete_multipart_upload != null ? rule.value.abort_incomplete_multipart_upload : []
        content {
          days_after_initiation = abort_incomplete_multipart_upload.value.days_after_initiation
        }
      }
    }


  }
}

# ################# public_access_block #####################

resource "aws_s3_bucket_public_access_block" "access_block" {
  for_each                = { for k, v in var.s3_bucket : k => v if v.access_block != null }
  bucket                  = each.value.bucket_name
  block_public_acls       = each.value.access_block[0].block_public_acls
  block_public_policy     = each.value.access_block[0].block_public_policy
  ignore_public_acls      = each.value.access_block[0].ignore_public_acls
  restrict_public_buckets = each.value.access_block[0].restrict_public_buckets
}

######### Bucket_metrics ##################
resource "aws_s3_bucket_metric" "metric-filtered" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name
  name     = each.value.name

  dynamic "filter" {
    for_each = each.value.filter
    content {
      prefix = filter.value.prefix
    }
    # dynamic "tags" {
    #   for_each = each.value.tags
    #   content {
    #     priority = tags.value.priority
    #     class    = tags.value.class
    #   }

    # }


  }
}


################ S3 bucket Policy ##########################
resource "aws_s3_bucket_policy" "public_read_access" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name
  policy   = data.aws_iam_policy_document.public_read_access[each.key].json
  depends_on = [
    aws_s3_bucket_public_access_block.access_block
  ]
}

data "aws_iam_policy_document" "public_read_access" {
  for_each = var.s3_bucket
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"

    ]
   resources = ["${aws_s3_bucket.my_bucket[each.key].arn}/*"]
    
  }

}

 
  
################## bucket_website_configuration ########################
// adding index.html file directly to the s3 bucket 
resource "aws_s3_bucket_website_configuration" "example" {
  for_each = var.s3_bucket
  bucket   = each.value.bucket_name

dynamic "index_document" {
  for_each = each.value.index_document
  content {
    suffix = index_document.value.suffix
  }
}
dynamic "error_document" {
  for_each = each.value.error_document != null ? each.value.error_document : []
  content {
  key = error_document.value.key
  }

}
# redirect_all_requests_to = each.value.error_document.redirect_all_requests_to


routing_rule {
  condition { 
    key_prefix_equals = each.value.routing_rule[0].condition[0].key_prefix_equals
  }
  redirect {
    replace_key_prefix_with = each.value.routing_rule[0].redirect[0].replace_key_prefix_with
  }
}

}



