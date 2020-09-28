module "build_wildRydes" {
  # globals
  source   = "../modules"
  
  # Global Variables
  region   = "us-east-2"
  app_name = "wildRydes"
  env      = "dnh"

  #S3 Bucket name
  bucket   = "wild-rydes-bucket"

  # Lambda Variables
  lambda_runtimes  = ["nodejs10.x"]

  # API GW


  # account_resources_state_bucket = "as-dma-sbx-tfstate"
  # account_resources_state_file = "dma-shared-resources/sbx/terraform.tfstate"
}

