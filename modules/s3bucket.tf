# --------------------------------------------------------
# S3 Bucket for static hosting 
# --------------------------------------------------------
resource "aws_s3_bucket" "wild_rydes_s3_tf" {
  bucket  = var.bucket
  acl     = var.bucket-acl

  policy  = templatefile("../modules/templates/policy_clientbucket.json", {
   bucket = var.bucket
})

website {
    index_document = var.index-document 
    error_document = var.error-document

  # static website hosting
    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
  tags = local.tags
}

# --------------------------------------------------------
# S3 Bucket for the Lambda function
# --------------------------------------------------------
resource "aws_s3_bucket" "wild_rydes_lambda_s3_tf" {
  bucket  = var.lambda-bucket
  acl     = var.bucket-acl
  
  policy  = templatefile("../modules/templates/policy_lambdabucket.json", {
   bucket = var.lambda-bucket
})

  tags = local.tags
}

# --------------------------------------------------------
# S3 Bucket Lambda configuration
# --------------------------------------------------------
resource "aws_s3_bucket_object" "dnh_clientfunction_s3_config" {
  bucket              = var.bucket
  key                 = var.function-key 
  content             = templatefile("../modules/templates/config_for_S3.tpl", {
                          userPoolId        = aws_cognito_user_pool.dnh_pool.id
                          userPoolClientId  = aws_cognito_user_pool_client.dnh_pool_client.id
                          region            = var.region
                          invokeUrl         = aws_api_gateway_deployment.dnh_api_deployment.invoke_url
      })
  content_type        = var.functon-content-type
  etag                = var.client-function-etag
}