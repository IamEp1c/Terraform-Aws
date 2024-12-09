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
# added response 
resource "aws_api_gateway_method_response" "example_response" {
  rest_api_id   = aws_api_gateway_rest_api.myDemoApi.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method = aws_api_gateway_method.example_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration" "example_integration" {
  rest_api_id             = aws_api_gateway_rest_api.myDemoApi.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.example_method.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.my_lambda.invoke_arn
}

# Lambda function for REST API
resource "aws_lambda_function" "my_lambda" {
  filename         = "lambda.zip"
  function_name    = "myRestApiLambda"
  role             = aws_iam_role.role.arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_iam_role" "role" {
  name               = "myrole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_api_gateway_deployment" "example_deployment" {
  depends_on  = [aws_api_gateway_integration.example_integration]
  rest_api_id = aws_api_gateway_rest_api.myDemoApi.id
  stage_name  = "dev"
}

resource "aws_lambda_function" "awsLambda" {
  role = aws_iam_role.lambda_role.arn
  function_name = "awsLambdafunc"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
    {
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
  ]
})
}

data "aws_caller_identity" "current" {}

output "api_endpoint" {
  value = aws_api_gateway_deployment.example_deployment.invoke_url
}


