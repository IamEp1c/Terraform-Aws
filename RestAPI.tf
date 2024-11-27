resource "aws_api_gateway_rest_api" "name" {
  name = "basicRestApi"
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
