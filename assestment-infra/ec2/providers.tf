terraform {
  required_version = "1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }

  backend "s3" {
    bucket = "oh-terraform"
    key    = "assetment-infra/ec2/assestment-infra-ec2.tfstate"
    region = "ap-southeast-1"
  }
}

# Define the provider
provider "aws" {
  region = "ap-southeast-1"
}