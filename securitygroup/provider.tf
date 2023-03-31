##########################################
# Configure backend S3 for tf state #
##########################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # backend "s3" {
  #   bucket     = "tfstates3bucket"
  #   key        = "sg-tfstate"
  #   region     = "us-east-1"
  #   profile = "dev-mfa"
  # }
}
##########################################
# Configure the AWS Provider #
##########################################
provider "aws" {
  region  = "us-east-1"
  profile = "dev-mfa"
}