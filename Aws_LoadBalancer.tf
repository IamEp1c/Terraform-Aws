resource "aws_lb" "creatingLB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets =           [	"subnet-0aef788bcd8d5319f" , "subnet-010f68d2392b7166e"]
  
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.s3_bucket_for_logs_01.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "s3_bucket_for_logs_01" {
  bucket        = "waqas-test-bucket"
  force_destroy = true
  # depends_on = [ aws_s3_bucket_server_side_encryption_configuration.example ]
}

# resource "aws_kms_key" "mykey" {
#   description             = "This key is used to encrypt bucket objects"
#   deletion_window_in_days = 10
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#   bucket = aws_s3_bucket.s3_bucket_for_logs_01.id

#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.mykey.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

# import {
#   to = aws_s3_bucket_policy.TestBucketPolicyLB
#   id = "my-tf-test-bucket"
# }
resource "aws_s3_bucket_policy" "TestBucketPolicyLB" {
  bucket = aws_s3_bucket.s3_bucket_for_logs_01.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_lb.creatingLB.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_bucket_for_logs_01.arn,
      "${aws_s3_bucket.s3_bucket_for_logs_01.arn}/*",
    ]
  }
}


# need vpc for IG, Subnet etc. Have one default vpc here for that purpose
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
