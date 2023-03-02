

#########################################################
# TERRAFORM BLOCK
#########################################################

terraform {
  required_version = ">=1.1.0"

  backend "s3" {
    bucket         = "backend-0201-lekan-kesh-buck"
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

#########################################################
# PROVIDER BLOCK
#########################################################

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      env       = "sandbox"
      component = var.component
    }

  }
}

#########################################################
# LOCAL BLOCK
#########################################################

locals {
  vpc_id = module.vpc.vpc_id
  azs    = slice(data.aws_availability_zones.available.names, 0, 2)
}

#########################################################
# DATA SOURCE BLOCK
#########################################################
data "aws_availability_zones" "available" {
  state = "available"

}

#########################################################
# VPC RESOURCE
#########################################################

module "vpc" {
  source = "git::https://github.com/lekankeshaws/vpc-module.git"

  component            = var.component_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = local.azs
  public_subnet_cidr   =  ["10.0.0.0/24"]
#   backend_subnet_cidr  = var.backend_subnet_cidr
#   database_subnet_cidr = var.database_subnet_cidr

}

resource "aws_security_group" "allow_jenkins" {
  name        = "jenkins_sg"
  description = "Allow jenkins inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.component}_jenkins_sg"
  }
}