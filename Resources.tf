# resource "aws_cloudtrail" "example" {
#   depends_on = [aws_s3_bucket_policy.waqasPolicy]

#   name                          = "example"
#   # s3_bucket_name                = aws_instance.waqasEc2.id
#   s3_bucket_name                = aws_s3_bucket.waqasBucket.id
#   # s3_key_prefix                 = "prefix"
#   include_global_service_events = false
# }

# resource "aws_s3_bucket_policy" "waqasPolicy" {
#   bucket = aws_s3_bucket.waqasBucket.id
#   policy = data.aws_iam_policy_document.example.json
#   #policy = "AWS":"arn:aws:iam::137068224818:root"
# }

# # data "aws_iam_policy_document" "allow_access_from_another_account" {
# #   statement {

# #     sid    = "AWSCloudTrailAclCheck"
# #     effect = "Allow"

# #     principals {
# #      type        = "AWS"
# #      identifiers = ["arn:aws:iam::137068224818:root"]
# #     }

# #     actions = [
# #       "s3:GetObject",
# #       "s3:ListBucket",
# #     ]

# #     resources = [
# #       aws_s3_bucket.waqasBucket.arn,
# #       "${aws_s3_bucket.waqasBucket.arn}/*",
# #     ]
# #   }
# # }

# data "aws_iam_policy_document" "example" {
#   statement {
#     sid    = "AWSCloudTrailAclCheck"
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }

#     actions   = ["s3:GetBucketAcl"]
#     resources = [
#       aws_s3_bucket.waqasBucket.arn, 
#       "${aws_s3_bucket.waqasBucket.arn}/*"
#       ]
#   }

#   statement {
#     sid    = "AWSCloudTrailWrite"
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["cloudtrail.amazonaws.com"]
#     }
#   }
# }

# resource "aws_s3_bucket" "waqasBucket" {
#   bucket        = "waqas-test-bucket"
#   force_destroy = true
# }


# resource "aws_instance" "waqasEc2" {
#   ami           = "ami-0ebfd941bbafe70c6"
#   instance_type = "t2.micro"
#   subnet_id = "subnet-06c5bfda9f5ef054f"
#   # for_each = toset(var.availabilityZones)
#   #tags = {
#   # Name = each.value
#   #}
# }

# # need vpc for IG, Subnet etc. Have one default vpc here for that purpose
# resource "aws_default_vpc" "default" {
#   tags = {
#     Name = "Default VPC"
#   }
# }

# resource "aws_iam_user" "newUser" {
#   name = "TestUser1"
# }