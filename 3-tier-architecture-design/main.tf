

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
  profile = "iamadmin"

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
  vpc_id = aws_vpc.sbx_vpc.id
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
resource "aws_vpc" "sbx_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

}

#########################################################
# INTERNET GATEWAY RESOURCE
#########################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "sbx_igw"
  }
}

#########################################################
# PUBLIC SUBNET RESOURCE
#########################################################
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

#########################################################
# BACKEND SUBNET RESOURCE
#########################################################
resource "aws_subnet" "backend_subnet" {
  count = length(var.backend_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.backend_subnet_cidr[count.index]
  availability_zone = local.azs[count.index] # element(local.azs, count.index) this is, incase you have more than 2 cidr

  tags = {
    Name = "backend_subnet_${count.index + 1}"
  }
}

#########################################################
# DATABASE SUBNET RESOURCE
#########################################################
resource "aws_subnet" "database_subnet" {
  count = length(var.database_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name = "database_subnet_${count.index + 1}"
  }
}

#########################################################
# PUBLIC ROUTE TABLE
#########################################################
resource "aws_route_table" "public_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

#########################################################
# DEFAULT ROUTE TABLE
#########################################################
resource "aws_default_route_table" "private_default_rt_table" {
  default_route_table_id = aws_vpc.sbx_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "sbx_default_rt_table"
  }
}

#########################################################
# PUBLIC ROUTE TABLE ASSOCIATION 
#########################################################

resource "aws_route_table_association" "public_rt_table" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#########################################################
# NAT GATEWAY
#########################################################

resource "aws_nat_gateway" "ngw" {
  depends_on = [aws_internet_gateway.igw]

  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "sbx_nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  
}

#########################################################
# ELASTIC IP
#########################################################

resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.igw]

  vpc      = true
}