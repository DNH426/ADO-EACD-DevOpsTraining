terraform {
  backend "s3" {
    bucket = "as-dma-sbx-tfstate"
    key    = "wildRydes/dnh/terraform.tfstate"
    region = "us-east-2"
  }
}

