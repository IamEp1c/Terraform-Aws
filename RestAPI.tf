resource "aws_api_gateway_rest_api" "myDemoApi" {
  name = "basicRestApi"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.myDemoApi.id
  parent_id   = aws_api_gateway_rest_api.myDemoApi.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "example_method" {
  rest_api_id   = aws_api_gateway_rest_api.myDemoApi.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "example_integration" {
  rest_api_id             = aws_api_gateway_rest_api.myDemoApi.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.example_method.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:lambda:us-east-1:${data.aws_caller_identity.current.account_id}:function:example-lambda" # here give your URI ID 
}

resource "aws_api_gateway_deployment" "example_deployment" {
  depends_on  = [aws_api_gateway_integration.example_integration]
  rest_api_id = aws_api_gateway_rest_api.myDemoApi.id
  stage_name  = "dev"
}

data "aws_caller_identity" "current" {}

output "api_endpoint" {
  value = aws_api_gateway_deployment.example_deployment.invoke_url
}


