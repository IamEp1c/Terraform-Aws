## Provides an Elastic Beanstalk Environment Resource. 
## Elastic Beanstalk allows you to deploy and manage applications in the AWS cloud without worrying about the infrastructure 
## that runs those applications.

# creates an s3 bucket make sure you delete

# resource "aws_elastic_beanstalk_application" "ebaTest1" {
#   name        = "Eba-Test"
#   description = "an EBA app to host static website, dev environment"
# }

# running issue with this resource 11/03/2024 , wasn't able to add

# resource "aws_elastic_beanstalk_environment" "tfenvtest" {
#   name                = "tf-test-name"
#   application         = aws_elastic_beanstalk_application.ebaTest.name
#   solution_stack_name = "64bit Amazon Linux 2 v3.11.2 running Go 1"
# }








