# Globals
variable "app_name" {
}

variable "env" {
}

variable "region" {
}

variable "app_name" {
  description = "application name - match app repo"
  default     = "wildrydes"
}

variable "env" {
  description = "deployment environment"
  default     = "dnh"
}

variable "region" {
  description = "region to build environment"
  default     = "us-east-2"
}

variable "bucket" {
  description = "S3 Bucket where the static website is stored"
  default = "wild-rydes-bucket"
}

variable "file" {
  default = "dma-shared-resources/sbx/terraform.tfstate"
}