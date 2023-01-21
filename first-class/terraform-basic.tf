# Terraform block
terraform {
    required_version = ">=1.1.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
    region = "us-east-1"
    profile = "iamadmin"
  
}

# Resource Block
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "main"
    }
}