# --------------------------------------------------------
# zip dnh-lambda.js file 
# --------------------------------------------------------
data "archive_file" "wild_rydes_lambda_function" {
  type        = var.file-type
  source_file = var.lambda-source-path
  output_path = var.lambda-output-path
}

# --------------------------------------------------------
# Apply requestUnicorn.js to the lambda function
# --------------------------------------------------------
resource "aws_lambda_function" "dnh_lambda" {
  filename      = var.lambda-output-path
  function_name = var.lambda-function-name
  role          = aws_iam_role.dnh_iam_lambda_role.arn
  handler       = var.lambda-handler
  runtime       = var.lambda-runtimes

   tags = local.tags
}



