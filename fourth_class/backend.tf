

###########################################################
# TERRAFORM BLOCK WITH BACKEND
#########################################################
terraform {
  required_version = ">=1.1.0"

  backend "s3" {
    bucket         = "backend-0131--lekan-kesh-buck"
    key            = "path/env"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}