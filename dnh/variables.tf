# --------------------------------------------------------
# Globals
# --------------------------------------------------------
module "build_wildRydes" {
  # Misc
  source                        = "../modules"
  region                        = "us-east-2"
  app-name                      = "wildRydes"
  env                           = "dnh"
  file-type                     = "zip"

  # S3 Buckets
  bucket                        = "dnh-wild-rydes-bucket"
  lambda-bucket                 = "dnh-wild-rydes-lambda-bucket"
  index-document                = "index.html"
  error-document                = "error.html" 
  function-key                  = "js/config.js"
  functon-content-type          = "application/javascript"
  client-function-etag          = "filemd5(../modules/templates/config_for_S3.tpl)"
  bucket-acl                    = "public-read"

  # Lambda / IAM
  lambda-runtimes               = "nodejs12.x"
  lambda-function-name          = "dnh-wild-rydes-lambda"
  lambda-role                   = "dnh-lambda-role"
  lambda-policy                 = "dnh-wild-rydes-write-access"
  lambda-source-path            = "../modules/Files_lambda_S3/requestUnicorn.js"
  lambda-output-path            = "../modules/Files_lambda_S3/dnh-lambda.zip"
  lambda-handler                = "requestUnicorn.handler"
    
  # Cognito
  cognito-user-pool-name        = "dnh-wild-rydes-pool"
  cognito-user-pool-client      = "dnh-pool-client"

  # # API GW
}

