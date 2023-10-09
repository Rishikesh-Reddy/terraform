terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "BuildIt" {
  source = "./BuildIt-module"

  app_name         = "BuildIT"
  environment_name = "dev"
}
