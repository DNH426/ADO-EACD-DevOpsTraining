# Add a tags.tf file, or put these locals in your variables.tf
locals { 
    tags = {
        Application = var.app_name
        Environment = var.env
    }
} 

# And then across (almost) all your TF resource blocks:
resource "aws_s3_bucket" "app_code_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"

  tags = local.tags
}

# If you need to add some additional tags, you can still use the local:
resource "aws_s3_bucket" "app_code_bucket" {
  bucket = "my-unique-bucket-name"
  acl    = "private"

  tags = merge(local.tags, { LambdaSourceCode = true })
}