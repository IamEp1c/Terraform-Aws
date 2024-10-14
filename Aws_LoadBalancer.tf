resource "aws_lb" "creatingLB" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets =           [	"subnet-0410ec127adfd11be" , "subnet-08430d9514d9cc592"]
  
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
}

# resource "aws_subnet" "main" {
#   vpc_id     = aws_default_vpc.default.id
#   # cidr_block = "172.31.0.0/20"

#   tags = {
#     Name = "Main"
#   }
# }

# need vpc for IG, Subnet etc. Have one default vpc here for that purpose
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
