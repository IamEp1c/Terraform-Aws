## Provides an Elastic Beanstalk Environment Resource. 
## Elastic Beanstalk allows you to deploy and manage applications in the AWS cloud without worrying about the infrastructure 
## that runs those applications.

resource "aws_elastic_beanstalk_application" "ebaTest" {
  name        = "Eba-Test"
  description = "an EBA app to host static website"
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.ebaTest.name
  solution_stack_name = "64bit Amazon Linux 2 v3.11.2 running Go 1"
}





