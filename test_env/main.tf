

#########################################################
# TERRAFORM BLOCK
#########################################################

terraform {
  required_version = ">=1.1.0"

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
  profile = "iamadmin"
}

#########################################################
# RESOURCE BLOCK
#########################################################

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${local.tags}-my_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(slice(local.azs, 0, 2), count.index)

  tags = {
    Name = "${local.tags}-public_subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = element(slice(local.azs, 0, 2), count.index)

  tags = {
    Name = "${local.tags}-private_subnet-${count.index + 1}"
  }
}

#########################################################
# LOCAL BLOCK
#########################################################

locals {
  vpc_id = aws_vpc.my_vpc.id
  tags   = "test_env"
  azs    = data.aws_availability_zones.available.names
}


#########################################################
# DATA SOURCE BLOCK
#########################################################

data "aws_availability_zones" "available" {
  state = "available"
}


#########################################################
# OUTPUT BLOCK
#########################################################

output "vpc_usage_id" {
  value = aws_vpc.my_vpc.id
}


#########################################################
# MODULE BLOCK
#########################################################