resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = ["subnet-016f5fb94dbc0127b", "subnet-04c2cfb1bdb5da111"]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.s3_bucket_for_logs_01.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_default_vpc.default.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_s3_bucket" "s3_bucket_for_logs_01" {
  bucket        = "waqas-test-bucket"
  force_destroy = true
  # depends_on = [ aws_s3_bucket_server_side_encryption_configuration.example ]
}

resource "aws_s3_bucket_policy" "TestBucketPolicyLB" {
  bucket = aws_s3_bucket.s3_bucket_for_logs_01.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      // added elb root id still throwing error 400
      identifiers = ["arn:aws:iam::127311923021:root"]
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
