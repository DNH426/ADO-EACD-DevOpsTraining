# --------------------------------------------------------
# IAM Role which holds lambda permission policies
# --------------------------------------------------------
resource "aws_iam_role" "dnh_iam_lambda_role" {
  name = var.lambda-role

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    },
     {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = local.tags
}

# --------------------------------------------------------
# IAM Policy that allows lambda to communicate with DynamoDB
# --------------------------------------------------------
resource "aws_iam_role_policy" "dnh_iam_policy_write_access" {
  name = var.lambda-policy
  role = aws_iam_role.dnh_iam_lambda_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
       {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:PutItem",
            "Resource": "${aws_dynamodb_table.dnh-rides.arn}"          
            
        }
    ]
  }
  EOF
}

# --------------------------------------------------------
# IAM Lambda Policy for log groups, streams, and events
# --------------------------------------------------------
resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.dnh_iam_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}