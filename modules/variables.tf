# --------------------------------------------------------
# Global Variables
# --------------------------------------------------------
# Misc
variable "app-name" {}
variable "env" {}
variable "region" {}
variable "file-type" {}

# S3
variable "bucket" {}
variable "lambda-bucket" {}
variable "index-document" {}
variable "error-document" {}
variable "function-key" {}
variable "functon-content-type" {}
variable "client-function-etag" {}
variable "bucket-acl" {}

# Lambda / IAM
variable "lambda-runtimes" {}
variable "lambda-function-name" {}
variable "lambda-role" {}
variable "lambda-policy" {}
variable "lambda-output-path" {}
variable "lambda-handler" {}
variable "lambda-source-path" {}

# Cognito
variable "cognito-user-pool-name" {}
variable "cognito-user-pool-client" {}

# # API Gateway
