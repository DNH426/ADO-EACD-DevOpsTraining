terraform {
  backend "s3" {
    bucket = "wild-rydes-bucket"
    key    = "wildRydes/sbx/terraform.tfstate"
    region = "us-east-2"
  }
}

