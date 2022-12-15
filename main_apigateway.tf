resource "aws_api_gateway_rest_api" "test-rest-api" {
  name = "resumeAPI-2.0"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.test-rest-api.id
  parent_id   = aws_api_gateway_rest_api.test-rest-api.root_resource_id
  path_part   = "{proxy+}" #this will make the resource proxy+ => handles all paths
}
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.test-rest-api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "POST"
  authorization = "NONE"
}
module "cors" {
  source  = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.test-rest-api.id
  api_resource_id = aws_api_gateway_resource.proxy.id

  allow_headers = [
    "Authorization",
    "Content-Type",
    "X-Amz-Date",
    "X-Amz-Security-Token",
    "X-Api-Key"
  ]

  allow_methods = [
    "OPTIONS",
    "POST"
  ]
}

#this is the INTEGRATION, it will route the requests to the lambda function that we defined
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.test-rest-api.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.resume-lambda-function.invoke_arn
}

#the following 2 blocks are applied to the root API resource 
# resource "aws_api_gateway_method" "proxy_root" {
#   rest_api_id   = aws_api_gateway_rest_api.test-rest-api.id
#   resource_id   = aws_api_gateway_rest_api.test-rest-api.root_resource_id
#   http_method   = "ANY"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "lambda_root" {
#   rest_api_id = aws_api_gateway_rest_api.test-rest-api.id
#   resource_id = aws_api_gateway_method.proxy_root.resource_id
#   http_method = aws_api_gateway_method.proxy_root.http_method

#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.resume-lambda-function.invoke_arn
# }

#DEPLOYING the API
resource "aws_api_gateway_deployment" "deploymnt-prod" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    # aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.test-rest-api.id
  stage_name  = "prod"
}
