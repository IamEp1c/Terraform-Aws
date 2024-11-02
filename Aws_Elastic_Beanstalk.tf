## Provides an Elastic Beanstalk Environment Resource. 
## Elastic Beanstalk allows you to deploy and manage applications in the AWS cloud without worrying about the infrastructure 
## that runs those applications.

resource "aws_elastic_beanstalk_application" "ebaTest" {
  name        = "Eba-Test"
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.ebaTest.name
  solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"
}
