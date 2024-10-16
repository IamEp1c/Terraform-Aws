# resource "aws_cloudtrail" "example" {
#   depends_on = [aws_s3_bucket_policy.example]

#   name                          = "example"
#   s3_bucket_name                = aws_s3_bucket.uniqueBucketExample104791.id
#   s3_key_prefix                 = "prefix"
#   include_global_service_events = false
# }

# resource "aws_s3_bucket" "uniqueBucketExample104791" {
#   bucket        = "tf-test-trail104791"
#   force_destroy = true
# }

# data "aws_iam_policy_document" "example" {
#   statement {
#     sid    = "AWSCloudTrailAclCheck"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:GetBucketAcl"]
#     resources = [aws_s3_bucket.uniqueBucketExample104791.arn]
#     condition {
#       test     = "StringEquals"
#       variable = "aws:SourceArn"
#       values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
#     }
#   }

#   statement {
#     sid    = "AWSCloudTrailWrite"
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:PutObject"]
#     resources = ["${aws_s3_bucket.uniqueBucketExample104791.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "s3:x-amz-acl"
#       values   = ["bucket-owner-full-control"]
#     }
#     condition {
#       test     = "StringEquals"
#       variable = "aws:SourceArn"
#       values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/example"]
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "example" {
#   bucket = aws_s3_bucket.uniqueBucketExample104791.id
#   policy = data.aws_iam_policy_document.example.json
# }

# resource "aws_s3_access_point" "example" {
#   bucket = aws_s3_bucket.uniqueBucketExample104791.id
#   name   = "example"
# }

# data "aws_caller_identity" "current" {}

# data "aws_partition" "current" {}

# data "aws_region" "current" {}