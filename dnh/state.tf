terraform {
  backend "s3" {
    bucket = "as-dma-sbx-tfstate"
    key    = "wildRydes/dev/terraform.tfstate"
    region = "us-east-2"
  }
}

