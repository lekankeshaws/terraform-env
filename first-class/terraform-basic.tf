
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

########### Resource Block ####################

# Creating EC2
resource "aws_instance" "test_server" {
  count = length(var.ami_list) # calling a list of ami in variable

  ami           = var.ami_list[count.index] # calling the list of ami variable
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1[count.index].id

  tags = {
    Name = "test_server"
  }
}

# Creating VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "public1" {

  count                   = length(var.public_subnet_cidr)
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = element(slice(local.azs, 0, 2), count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# resource "aws_subnet" "public2" {
#   vpc_id            = local.vpc_id
#   cidr_block        = var.cidr_block[2]
#   availability_zone = data.aws_availability_zones.available.names[1]

#   tags = {
#     Name = "public2"
#   }
# }

resource "aws_subnet" "private1" {
  count = length(var.private_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = element(slice(local.azs, 0, 2), count.index)

  tags = {
    Name = "private_subnet${count.index + 1}"
  }
}

# resource "aws_subnet" "private2" {
#   vpc_id            = local.vpc_id
#   cidr_block        = var.cidr_block[4]
#   availability_zone = data.aws_availability_zones.available.names[1]

#   tags = {
#     Name = "private2"
#   }
# }

########### DATA SOURCE BLOCK ############


# data "aws_subnet" "selected" {
#   id = var.subnet_id

# }