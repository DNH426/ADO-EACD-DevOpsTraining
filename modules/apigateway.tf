# --------------------------------------------------------
# Usage with Cognito User Pool Authorizer
# --------------------------------------------------------
# data "aws_cognito_user_pools" "this" {
#   name = var.cognito_user_pool_name
# }

# --------------------------------------------------------
# API Gateway for the WildRydes application
# --------------------------------------------------------
resource "aws_api_gateway_rest_api" "dnh_wild_rydes_api" {
  name                    = "DNH-Wild-Rydes-API"
  description             = "This is my API for the Wild Rydes applicaiton"

  tags = local.tags
} 

# --------------------------------------------------------
# Authorizer for the API gateway which will use the Cognito user pool for authorization and IAM roles
# Authorizers enable you to control access to your APIs using Amazon Cognito User Pools or a Lambda function
# with type COGNITO_USER_POOLS
# --------------------------------------------------------
resource "aws_api_gateway_authorizer" "dnh_wild_rydes_auth" {
  name                   = "DNH-Wild-Rydes-Auth"
  rest_api_id            = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  authorizer_uri         = aws_lambda_function.dnh_lambda.invoke_arn
  authorizer_credentials = aws_iam_role.dnh_iam_lambda_role.arn
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [aws_cognito_user_pool.dnh_pool.arn] // string []arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id} .arns maybe not needed
} 

# --------------------------------------------------------
# This creates a "ride" resource within the API gateway
# --------------------------------------------------------
resource "aws_api_gateway_resource" "dnh_request_ride_resource"  {
  rest_api_id           = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  parent_id             = aws_api_gateway_rest_api.dnh_wild_rydes_api.root_resource_id
  path_part             = "ride"
} 

# --------------------------------------------------------
# This creates the POST and the OPTIONS (for CORS) method for the API gateway
# For POST, authorization is set as "COGNITO_USER_POOLS" and for CORS this is set as "NONE."
# --------------------------------------------------------
resource "aws_api_gateway_method" "dnh_apigateway_method" {
  rest_api_id         = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  resource_id         = aws_api_gateway_resource.dnh_request_ride_resource.id
  http_method         = "POST"
  authorization       = "COGNITO_USER_POOLS"
  authorizer_id       = aws_api_gateway_authorizer.dnh_wild_rydes_auth.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
} 

# --------------------------------------------------------
# Creates an integration for the API gateway, resource, and the method
# This is used for both POST 
# -------------------------------------------------------
resource "aws_api_gateway_integration" "dnh_integration" {
  rest_api_id             = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  resource_id             = aws_api_gateway_resource.dnh_request_ride_resource.id
  http_method             = aws_api_gateway_method.dnh_apigateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.dnh_lambda.invoke_arn
}

# -----------------------------------------------------------------------------------------------
# This is used to set the response for CORS with appropriate response parameters
# -----------------------------------------------------------------------------------------------
resource "aws_api_gateway_integration_response" "dnh_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  resource_id = aws_api_gateway_resource.dnh_request_ride_resource.id
  http_method = aws_api_gateway_method.dnh_apigateway_method.http_method
  status_code = "200"

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/xml" = <<EOF
#set($inputRoot = $input.path('$'))
<?xml version="1.0" encoding="UTF-8"?>
<message>
    $inputRoot.body
</message>
EOF
  }
} 

# --------------------------------------------------------
# This is used to set the response for CORS with appropriate response parameters
# --------------------------------------------------------
resource "aws_api_gateway_method_response" "dnh_method_response" {
  rest_api_id   = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  resource_id   = aws_api_gateway_resource.dnh_request_ride_resource.id
  http_method   = aws_api_gateway_method.dnh_apigateway_method.http_method
  status_code   = "200"
} 

# --------------------------------------------------------
# This resource is used to provide (by lambda) permissions to the API gateway
# --------------------------------------------------------
resource "aws_lambda_permission" "dnh_api_lambda_permission" {
  statement_id  = "AllowMyRequestAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dnh_lambda.function_name
  principal     = "apigateway.amazonaws.com"


  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn =  # "${aws_api_gateway_rest_api.MyDemoAPI.execution_arn}/*/*/*"
} 

# --------------------------------------------------------
# Deploy the API to the "Test" stage
# --------------------------------------------------------
resource "aws_api_gateway_deployment" "dnh_api_deployment" {
  depends_on   = [aws_api_gateway_integration.dnh_integration]

  rest_api_id  = aws_api_gateway_rest_api.dnh_wild_rydes_api.id
  stage_name   = "dnh"

  variables    = {
    "answer" = "42"
  }

  lifecycle {
    create_before_destroy = true
  }
}