# Terraform block
terraform {
  required_version = ">=1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "iamadmin"

}

####### VPC Module Block #############

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = var.private_ips
  public_subnets  = var.public_ips

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

####### Data Block ###########
data "aws_availability_zones" "available" {
  state = "available"
}