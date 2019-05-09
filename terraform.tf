terraform {
  required_version = ">= 0.11.9"

  backend "s3" {
    encrypt        = true
    bucket         = "abhishek-terraform-state-storage-bucket"
    region         = "us-east-2"
    dynamodb_table = "abhishek-terraform-state-lock-dynamodb-table"
    key            = "states/ekscluster.tfstate"
  }
}

provider "aws" {
  profile = "${var.aws_profile}"
  region  = "us-east-2"
}