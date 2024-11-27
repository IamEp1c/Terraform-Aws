resource "aws_api_gateway_rest_api" "myDemoApi" {
  name = "basicRestApi"
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.myDemoApi.id
  parent_id = aws_api_gateway_rest_api.myDemoApi.root_resource_id
  path_part   = "mydemoresource"
}
