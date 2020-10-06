terraform {
  backend "s3" {
    bucket = "as-dma-sbx-tfstate"
    key    = "wildRydes/sbx/terraform.tfstate"
    region = "us-east-2"
  }
}

