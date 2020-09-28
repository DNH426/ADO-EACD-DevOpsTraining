# And then across (almost) all your TF resource blocks:
resource "aws_s3_bucket" "wild_rydes_s3_tf" {
  bucket = "${var.bucket}"
  acl    = "public-read"

website {
    index_document = "index.html"
    error_document = "error.html" // looking into error page 
  }
  // created a tags.tf file to call
  tags = local.tags
}
