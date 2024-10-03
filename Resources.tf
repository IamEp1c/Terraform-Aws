resource "aws_cloudtrail" "example" {
  depends_on = [aws_s3_bucket_policy.waqasPolicy]

  name                          = "example"
  s3_bucket_name                = aws_instance.waqasEc2.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket_policy" "waqasPolicy" {
  bucket = aws_s3_bucket.waqasBucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    # principals {
    #   type        = "AWS"
    #   # identifiers = ["AWS":"arn:aws:iam::AccountIDWithoutHyphens:root"]
    #   identifiers = {"AWS":"arn:aws:iam::137068224818:root"}
    # }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.waqasBucket.arn,
      "${aws_s3_bucket.waqasBucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket" "waqasBucket" {
  bucket        = "waqas-test-bucket"
  force_destroy = true
}


resource "aws_instance" "waqasEc2" {
  ami           = "ami-0ebfd941bbafe70c6"
  instance_type = "t2.micro"
  subnet_id = "subnet-02b0f86f8d964c245"
  # for_each = toset(var.availabilityZones)
  #tags = {
  # Name = each.value
  #}
}

# need vpc for IG, Subnet etc. Have one default vpc here for that purpose
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_iam_user" "newUser" {
  name = "TestUser1"
}